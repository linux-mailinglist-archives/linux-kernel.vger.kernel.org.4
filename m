Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5711690AE1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjBINvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjBINvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:51:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E283C2B2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675950662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5tQrzwoV3t9Ch/0Dq/FO83jB00+J9QP6+xd5wU9EE4=;
        b=E+bOHzthSilyejG3ds/WSkXii8jTgDNcW9RTvzxdaRdYVfLX5cIzqPNr/0bSx36uZwtLTY
        +znreyY1powRr9+vIlfsM3QQe0fzPd0RCu8wFbX//VHu/2vDYq1Ys+697OSzNXToj1nmjN
        LAJxu9KhrAkvFrMB/nW5NQXxADveqvs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-FOXoZO4LNpGpzHTxFg9kVg-1; Thu, 09 Feb 2023 08:50:56 -0500
X-MC-Unique: FOXoZO4LNpGpzHTxFg9kVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01482803520;
        Thu,  9 Feb 2023 13:50:54 +0000 (UTC)
Received: from plouf.local (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81B19400DB1E;
        Thu,  9 Feb 2023 13:50:51 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20230207024816.525938-1-dianders@chromium.org>
References: <20230207024816.525938-1-dianders@chromium.org>
Subject: Re: (subset) [PATCH 0/7] arm: qcom: Fix touchscreen voltage for
 sc7280-herobrine boards
Message-Id: <167595065101.337240.12878703764198132712.b4-ty@redhat.com>
Date:   Thu, 09 Feb 2023 14:50:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 18:48:09 -0800, Douglas Anderson wrote:
> Trying to figure out how to talk to the touchscreen properly on
> sc7280-herobrine boards was a long and difficult process. Many
> Engineering hours were spent deciding how exactly one should talk over
> i2c to a peripheral. In the end, a solution has been found and this
> patch series attempts to implement it in a way that will work for all
> herobrine-based boards.
> 
> [...]

Applied to hid/hid.git (for-6.3/i2c-hid), thanks!

[4/7] HID: i2c-hid: goodix: Stop tying the reset line to the regulator
      https://git.kernel.org/hid/hid/c/557e05fa9fdd
[5/7] dt-bindings: HID: i2c-hid: goodix: Add mainboard-vddio-supply
      https://git.kernel.org/hid/hid/c/1d18c1f3b7d9
[6/7] HID: i2c-hid: goodix: Add mainboard-vddio-supply
      https://git.kernel.org/hid/hid/c/eb16f59e8e58

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

