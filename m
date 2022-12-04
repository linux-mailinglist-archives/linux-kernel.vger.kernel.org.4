Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34E2641AB2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 05:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiLDElg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 23:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLDEle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 23:41:34 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160101A824
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 20:41:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6EB8F425BC;
        Sun,  4 Dec 2022 04:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1670128890; bh=5+KLQR8NSpaMWiDJHnWtLY3V2e2+4V2U6koCh9qGy1k=;
        h=Date:From:Subject:To:Cc;
        b=pJgmEOxyjrcoi/u0oHLQJlKeWtJ8+Wv945T3SrDwccGlwuE7K5mhx7SYHJ6b60KlU
         +g/OHwn/JmbXOIc6q4M36e5wZOuohPbjkKHzohDuZ7+dIwy3eJQz+PrXQ+lE2cxpff
         pwNp9jO7wND2ZghwD5uG4sqzGwpLQlh/f6rteAwJIXBwu1uX12NjMUULE1qZGpE5S5
         grYJcs3GVYOtE/+1IkEYwlBdWhrfQYvQ5e+aL/1as5maIXWxrN8+C3yqBljelBMmGu
         t/p/z5vR3aeS5T8XVK3/tK8yYDAYbTFk5094ueZQ0jGp0N8/mWdOu2xWforotbaxf9
         3TJCqBgLjwjwA==
Message-ID: <a9353121-7fed-fde7-6f40-939a65bfeefb@marcan.st>
Date:   Sun, 4 Dec 2022 13:41:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC DT updates for 6.2 (v2)
To:     SoC Team <soc@kernel.org>
Content-Language: en-US
Cc:     Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi SoC folks,

Please merge these DT changes for 6.2 (I hear there's likely going to be
an -rc8, so hopefully this won't be too late).

This batch pulls in the CPUfreq DT updates that go along with the
respective driver, which is already queued for 6.2. It also includes a
patch from robh to add the cache topology for t600x (t8103 still pending).

-Hector

The following changes since commit 56fed763f6b2dc2578ea8c3e7d317722d8581cba:

  arm64: dts: apple: Add ADMAC resets on t8103/t600x (2022-10-24 13:44:22 +0900)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-dt-6.2-v2

for you to fetch changes up to d32c1530c7230b756ca9a6b6cf92ce6e60788594:

  arm64: dts: apple: Add CPU topology & cpufreq nodes for t600x (2022-12-04 13:31:59 +0900)

----------------------------------------------------------------
Apple SoC DT updates for 6.2 (v2).

This includes:
* L1/L2 cache topology for t600x
* CPUfreq nodes for t8103/t600x
* DT binding for CPUfreq
* Associated MAINTAINERS update

The CPUfreq driver was already merged for 6.2 via its tree.

----------------------------------------------------------------
Hector Martin (4):
      MAINTAINERS: Add entries for Apple SoC cpufreq driver
      dt-bindings: cpufreq: apple,soc-cpufreq: Add binding for Apple SoC cpufreq
      arm64: dts: apple: Add CPU topology & cpufreq nodes for t8103
      arm64: dts: apple: Add CPU topology & cpufreq nodes for t600x

Rob Herring (1):
      arm64: dts: apple: Add t600x L1/L2 cache properties and nodes

 .../bindings/cpufreq/apple,cluster-cpufreq.yaml    | 117 ++++++++++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/apple/t6002.dtsi               | 123 ++++++++++-
 arch/arm64/boot/dts/apple/t600x-common.dtsi        | 237 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t600x-dieX.dtsi          |  18 ++
 arch/arm64/boot/dts/apple/t8103.dtsi               | 204 +++++++++++++++++-
 6 files changed, 690 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml

