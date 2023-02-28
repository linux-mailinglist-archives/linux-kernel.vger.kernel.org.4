Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9E96A60FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjB1VL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjB1VLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:11:21 -0500
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 13:11:17 PST
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C970C2B294
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:11:17 -0800 (PST)
Received: from [192.168.2.144] (bband-dyn207.178-40-209.t-com.sk [178.40.209.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BE87620166;
        Tue, 28 Feb 2023 22:11:14 +0100 (CET)
Date:   Tue, 28 Feb 2023 22:11:09 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v8 2/3] mfd: axp20x: Add support for AXP313a PMIC
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     martin.botka1@gmail.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <LU6TQR.1KVYI23YNZDD3@somainline.org>
In-Reply-To: <TY3P286MB261112915A6811BB91E8DE6C98A69@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <20230120184500.1899814-1-martin.botka@somainline.org>
        <20230120184500.1899814-3-martin.botka@somainline.org>
        <TY3P286MB261112915A6811BB91E8DE6C98A69@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Shengyu
On Sun, Feb 19 2023 at 01:52:50 AM +08:00:00, Shengyu Qu 
<wiagn233@outlook.com> wrote:
> Hi Martin,
>> +static const struct regmap_range axp313a_writeable_ranges[] = {
>> +	regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),
> No, according to datasheet, 0x00 reg is read-only.
>> +};
>> +
>> +static const struct regmap_range axp313a_volatile_ranges[] = {
>> +	regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),
> 
> As Tsai said, no meaning to set all register to volatile.
ack
> 
> Also, please check the datasheet I metioned in part3 reply, seems its
> newer than yours.
ack
> 
> Best regards,
> 
> Shengyu
> 
Best regards,

Martin


