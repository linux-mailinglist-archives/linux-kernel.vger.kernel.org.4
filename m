Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE8E7311E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbjFOIRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFOIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:17:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E61381BF8;
        Thu, 15 Jun 2023 01:17:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0A611FB;
        Thu, 15 Jun 2023 01:18:17 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C48DB3F71E;
        Thu, 15 Jun 2023 01:17:29 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Konrad Dybcio <konradybcio@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Hao Zhang <quic_hazha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>
Subject: Re: [PATCH v6 0/3] Add support to configure Coresight Dummy subunit
Date:   Thu, 15 Jun 2023 09:16:38 +0100
Message-Id: <168681694253.417491.1580155663436908350.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602084149.40031-1-quic_hazha@quicinc.com>
References: <20230602084149.40031-1-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 16:41:46 +0800, Hao Zhang wrote:
> Introduction of Coresight Dummy subunit
> The Coresight Dummy subunit is for Coresight Dummy component, there are
> some specific Coresight devices that HLOS don't have permission to access.
> Such as some TPDMs, they would be configured in NON-HLOS side, but it's
> necessary to build Coresight path for it to debug. So there need driver to
> register dummy devices as Coresight devices.
> 
> [...]

Applied, thanks!

[1/3] Coresight: Add coresight dummy driver
      commit: 9d3ba0b6c056918355cf36094d6ed63cdd01a2ab
[2/3] dt-bindings: arm: Add support for Coresight dummy trace
      commit: 5911ff4559e45532c1f67257c5731b5e13f5e7a3
[3/3] Documentation: trace: Add documentation for Coresight Dummy Trace
      commit: 3b79104f80036231a40ba5d15c3e329985029a0f

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
