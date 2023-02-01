Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD4A686303
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBAJmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjBAJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:42:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5AD5EF97;
        Wed,  1 Feb 2023 01:42:01 -0800 (PST)
Received: from pendragon.ideasonboard.com (unknown [193.209.96.36])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE489505;
        Wed,  1 Feb 2023 10:41:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675244519;
        bh=M/MHomcjcCn4XroQOgrgcI0/sd/srmSceu6sHey7G88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vX2idoyciOfF83kYW0eDhlnWZ95i6rLwtbR2jFBD2aF1ObxigX3CgeKA7hP8MULcM
         bowZRQR0sVj67tV5d4wwQD/6bDrCh405oCbvs1nZouh2EzM4LoU1ozX2eUqttq4Cvn
         ZcaRXrIUTI4Qp1o8BEIquikpmp/layzlO4sA16g8=
Date:   Wed, 1 Feb 2023 11:41:56 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     yuji2.ishikawa@toshiba.co.jp
Cc:     sakari.ailus@iki.fi, hverkuil@xs4all.nl, mchehab@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael.j.wysocki@intel.com,
        broonie@kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Message-ID: <Y9oz5MDMmopBq5h9@pendragon.ideasonboard.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-3-yuji2.ishikawa@toshiba.co.jp>
 <Y8cjqoztUTIL61dP@valkosipuli.retiisi.eu>
 <TYAPR01MB62010040B750701D253C47CB92D19@TYAPR01MB6201.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYAPR01MB62010040B750701D253C47CB92D19@TYAPR01MB6201.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ishikawa-san,

On Wed, Feb 01, 2023 at 02:02:43AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> Hello Sakari,
> 
> Sorry for sending the reply again. 
> My mail agent posted the previous one with HTML format.
> 
> Thank you for reviewing and your comments.
> 
> > -----Original Message-----
> > From: Sakari Ailus sakari.ailus@iki.fi
> > Sent: Wednesday, January 18, 2023 7:40 AM
> > To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
> > yuji2.ishikawa@toshiba.co.jp
> > Cc: Hans Verkuil hverkuil@xs4all.nl; Laurent Pinchart
> > laurent.pinchart@ideasonboard.com; Mauro Carvalho Chehab
> > mchehab@kernel.org; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
> > nobuhiro1.iwamatsu@toshiba.co.jp; Rob Herring robh+dt@kernel.org;
> > Krzysztof Kozlowski krzysztof.kozlowski+dt@linaro.org; Rafael J . Wysocki
> > rafael.j.wysocki@intel.com; Mark Brown broonie@kernel.org;
> > linux-media@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [PATCH v5 2/6] media: platform: visconti: Add Toshiba Visconti
> > Video Input Interface driver

[snip]

> > > diff --git a/drivers/media/platform/visconti/hwd_viif_reg.h b/drivers/media/platform/visconti/hwd_viif_reg.h
> > > new file mode 100644
> > > index 00000000000..b7f43c5fe95
> > > --- /dev/null
> > > +++ b/drivers/media/platform/visconti/hwd_viif_reg.h
> > > @@ -0,0 +1,2802 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> > > +/* Toshiba Visconti Video Capture Support
> > > + *
> > > + * (C) Copyright 2022 TOSHIBA CORPORATION
> > > + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> > > + */
> > > +
> > > +#ifndef HWD_VIIF_REG_H
> > > +#define HWD_VIIF_REG_H
> > > +
> > > +/**
> > > + * struct hwd_viif_csi2host_reg - Registers for VIIF CSI2HOST control
> > > + */
> > > +struct hwd_viif_csi2host_reg {
> > > +    u32 RESERVED_A_1;
> > > +    u32 CSI2RX_NLANES;
> > > +    u32 CSI2RX_RESETN;
> > > +    u32 CSI2RX_INT_ST_MAIN;
> > > +    u32 CSI2RX_DATA_IDS_1;
> > > +    u32 CSI2RX_DATA_IDS_2;
> > > +    u32 RESERVED_B_1[10];
> > > +    u32 CSI2RX_PHY_SHUTDOWNZ;
> > > +    u32 CSI2RX_PHY_RSTZ;
> > > +    u32 CSI2RX_PHY_RX;
> > > +    u32 CSI2RX_PHY_STOPSTATE;
> > > +    u32 CSI2RX_PHY_TESTCTRL0;
> > > +    u32 CSI2RX_PHY_TESTCTRL1;
> > > +    u32 RESERVED_B_2[34];
> > > +    u32 CSI2RX_INT_ST_PHY_FATAL;
> > > +    u32 CSI2RX_INT_MSK_PHY_FATAL;
> > > +    u32 CSI2RX_INT_FORCE_PHY_FATAL;
> > > +    u32 RESERVED_B_3[1];
> > > +    u32 CSI2RX_INT_ST_PKT_FATAL;
> > > +    u32 CSI2RX_INT_MSK_PKT_FATAL;
> > > +    u32 CSI2RX_INT_FORCE_PKT_FATAL;
> > > +    u32 RESERVED_B_4[1];
> > > +    u32 CSI2RX_INT_ST_FRAME_FATAL;
> > > +    u32 CSI2RX_INT_MSK_FRAME_FATAL;
> > > +    u32 CSI2RX_INT_FORCE_FRAME_FATAL;
> > > +    u32 RESERVED_B_5[1];
> > > +    u32 CSI2RX_INT_ST_PHY;
> > > +    u32 CSI2RX_INT_MSK_PHY;
> > > +    u32 CSI2RX_INT_FORCE_PHY;
> > > +    u32 RESERVED_B_6[1];
> > > +    u32 CSI2RX_INT_ST_PKT;
> > > +    u32 CSI2RX_INT_MSK_PKT;
> > > +    u32 CSI2RX_INT_FORCE_PKT;
> > > +    u32 RESERVED_B_7[1];
> > > +    u32 CSI2RX_INT_ST_LINE;
> > > +    u32 CSI2RX_INT_MSK_LINE;
> > > +    u32 CSI2RX_INT_FORCE_LINE;
> > > +    u32 RESERVED_B_8[113];
> > > +    u32 RESERVED_A_2;
> > > +    u32 RESERVED_A_3;
> > > +    u32 RESERVED_A_4;
> > > +    u32 RESERVED_A_5;
> > > +    u32 RESERVED_A_6;
> > > +    u32 RESERVED_B_9[58];
> > > +    u32 RESERVED_A_7;
> > 
> > These should be lower case, they're struct members.
> > 
> > This way of defining a hardware register interface is highly
> > unconventional. I'm not saying no to it, not now at least, but something
> > should be done to make this more robust against accidental changes: adding
> > a field in the middle changes the address of anything that comes after it,
> > and it's really difficult to say from the code alone that the address of a
> > given register is what it's intended to be. Maybe pahole would still help?
> > But some documentation would be needed in that case.
> > 
> > I wonder what others think.
> 
> I understand the risk.
> I'll remove these struct-style definition and introduce macro style definition.
> I've hesitated this migration simply because it seemed difficult to complete without any defects 
> especially on calculating the offset of each member.
> I try find a series of operations that will complete the migration safely.

I agree with you about the migration risk. Maybe a script that parses
the header file and generates macros would take less time to implement
than doing it manually, and would be safer ?

> > > +};
> > > +

-- 
Regards,

Laurent Pinchart
