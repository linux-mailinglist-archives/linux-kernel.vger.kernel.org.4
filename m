Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EED630E29
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 11:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKSK5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 05:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 05:57:21 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284A2976E6;
        Sat, 19 Nov 2022 02:57:21 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 396555C013C;
        Sat, 19 Nov 2022 05:57:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 19 Nov 2022 05:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668855440; x=1668941840; bh=UYi9C6IaaZ
        ioVaoTtatSi/ezY/KuSuWAipoDncaQtSw=; b=x0P7l1jkb30Z8LOGNzKvuBE77L
        z3mtki6AnApaTgqxnUcwabvym1uihf3oYOvQOQBax6CGfS208No7KtL6GwZKOijt
        3I5ZpmuAcbeG3iDmqBKaxqVpA/1fkAHpD1Wlh2XgVQKhUX4tBrx+CuWZVu1f4P0V
        ZKyFytHoqE/ecfh78FEto/CyW0DUvAo/q4QFvuFG5UVBzW2j9wvQiS6O6p1FuO7K
        FmFewnZtPKGU/Tncr2Ik90Sq5IJkZzSRb3CzJ+UDfuNumcha2pzk4AK3flydUBQB
        Hqq1/aDHgaYOKmbbykARp9GeGWMQngXaLAHCT2XFiuhbyPmtA5GGVyNjqm7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668855440; x=1668941840; bh=UYi9C6IaaZioVaoTtatSi/ezY/Ku
        SuWAipoDncaQtSw=; b=G96HHULYX4cJ7z5jPX/Y6cGqpx78nWKZUl0VuYionmAb
        zxyMAsmtL6wSiVj5Q04fK0mczXA901/mS1dIo3MLNiYqd5eKoFyrGG13uETWlg+m
        sjgzswGf64KCOKiiHA4a1Z9vSKxN5IeMpDZ6ZGofpXmhVq1kWzKnNtjL8NnHYtF2
        UHBgCIAa4vxpxjnx++5JT1CTT6SPGgJj/m9mfdb9/oRGQrWtcC8ShToSjFhaEycc
        dzy1EzetDWRTM0q7phYDwbqVG0fdusLGh+RJ32B2UxNlpTDY3HSjT2dN0ssyqcj+
        KVcTkXh49ac9H/wKQ3/Y2PtLbgisTKB6R+pQqXdgYg==
X-ME-Sender: <xms:j7Z4Y5Yz6xwEDKqgalnFmb_JNuThR_SW1syDbDnZmrmjyWCTUOLw5A>
    <xme:j7Z4YwbXu4qPpP2ArHd1EFkjqs104mHyJy4gDGcyUy8XoywqO50z8LEIyqr52urJo
    cc21Ov7vd21SkC5Z_c>
X-ME-Received: <xmr:j7Z4Y79JEjp4GDg2UGsTfbj3mQdNSx7YMBFO7yOjlCIgaTKP_qo-uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeffrghfnhgr
    ucfjihhrshgthhhfvghlugcuoegurghfnhgrsehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdehtdeludekgeevleefuedvudejieetheekvdfhteekffdujefh
    fedtudehvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepuggrfhhnrgesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kLZ4Y3psAgutEyeZv9YJzi0RPrKUJtYculTCH3pwriTPkAktmitkvQ>
    <xmx:kLZ4Y0qQOebJfqTYVdIeyFjNE66SG6QHU2jnOLDhgiRlA-J0tS7dcQ>
    <xmx:kLZ4Y9SHQ2_mXVygLjvFt7iHy4xr8NJSNjgd1pg27gXcmvB_HLzJPQ>
    <xmx:kLZ4Y1eqhHlksrLxAbexYVBoyUkD7-gDMXvVPaYfenkdnFVEYG0VZA>
Feedback-ID: i0e894699:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Nov 2022 05:57:17 -0500 (EST)
Date:   Sat, 19 Nov 2022 12:57:14 +0200
From:   Dafna Hirschfeld <dafna@fastmail.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: rkisp1: Implement ENUM_FRAMESIZES
Message-ID: <20221119105714.6ynnl2jvfwnb4flw@guri>
References: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
 <20221117084217.3892680-4-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20221117084217.3892680-4-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.2022 17:42, Paul Elder wrote:
>Implement VIDIOC_ENUM_FRAMESIZES for the rkisp1 capture devices.
>
>Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
>Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Dafna Hirschfeld <dafna@fastmail.com>

>---
> .../platform/rockchip/rkisp1/rkisp1-capture.c | 30 +++++++++++++++++++
> 1 file changed, 30 insertions(+)
>
>diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>index 91e685fdbbe9..03c2922bfbed 100644
>--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>@@ -1236,6 +1236,35 @@ static int rkisp1_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
> 	return -EINVAL;
> }
>
>+static int rkisp1_enum_framesizes(struct file *file, void *fh,
>+				  struct v4l2_frmsizeenum *fsize)
>+{
>+	static const unsigned int max_widths[] = {
>+		RKISP1_RSZ_MP_SRC_MAX_WIDTH,
>+		RKISP1_RSZ_SP_SRC_MAX_WIDTH,
>+	};
>+	static const unsigned int max_heights[] = {
>+		RKISP1_RSZ_MP_SRC_MAX_HEIGHT,
>+		RKISP1_RSZ_SP_SRC_MAX_HEIGHT,
>+	};
>+	struct rkisp1_capture *cap = video_drvdata(file);
>+
>+	if (fsize->index != 0)
>+		return -EINVAL;
>+
>+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
>+
>+	fsize->stepwise.min_width = RKISP1_RSZ_SRC_MIN_WIDTH;
>+	fsize->stepwise.max_width = max_widths[cap->id];
>+	fsize->stepwise.step_width = 2;
>+
>+	fsize->stepwise.min_height = RKISP1_RSZ_SRC_MIN_HEIGHT;
>+	fsize->stepwise.max_height = max_heights[cap->id];
>+	fsize->stepwise.step_height = 2;
>+
>+	return 0;
>+}
>+
> static int rkisp1_s_fmt_vid_cap_mplane(struct file *file,
> 				       void *priv, struct v4l2_format *f)
> {
>@@ -1285,6 +1314,7 @@ static const struct v4l2_ioctl_ops rkisp1_v4l2_ioctl_ops = {
> 	.vidioc_s_fmt_vid_cap_mplane = rkisp1_s_fmt_vid_cap_mplane,
> 	.vidioc_g_fmt_vid_cap_mplane = rkisp1_g_fmt_vid_cap_mplane,
> 	.vidioc_enum_fmt_vid_cap = rkisp1_enum_fmt_vid_cap_mplane,
>+	.vidioc_enum_framesizes = rkisp1_enum_framesizes,
> 	.vidioc_querycap = rkisp1_querycap,
> 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
> 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
>-- 
>2.35.1
>
