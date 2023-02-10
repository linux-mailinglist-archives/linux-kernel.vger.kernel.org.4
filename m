Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05B66921A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjBJPIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjBJPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:08:40 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603056CC6D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:08:28 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g18so6015434qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NeXajktN08gdTqt/pb1PeyZwlRPXP0HIHSrcxP/wobQ=;
        b=4tz0G1FmuViqvkhIudhqhbw7o48RF15bvCVJ8whu4nFj5BzkWYRhwDP0DBuBbHvyOV
         2TCufrhYIxparXIirM90ae67HytZTXY/OMR8LIdwRNjy47yvWYpCcRUNfgOxK1Ndv9F+
         Wamp2/MbQ3FQO/OZ85pKweJ9/iJI15npFgEqKYhdrgM7mpuh1nEUKAMQmw23Jw3GZrvg
         Axdqe4O7ahSdl0QU8+5JfRxdubpUHIxL9jskCp5CSGAdWY8daWMIExB6afUNwedX2jWu
         YYJqYpVKt0h0BPR7B7jcN+2hen/rwlidcyifr/DFVHQ05EO1URsMHg0w/DaEApuGGlG6
         RASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NeXajktN08gdTqt/pb1PeyZwlRPXP0HIHSrcxP/wobQ=;
        b=JovWpIKhOE490Qp8+H5t6WKGLYihJpjmdbPgLegQ8RaTxMc9hXiTrwL25kG939Yden
         lqWSenAa97F/XN69I+3AUCaBVSzN/9JMkuhkfEd1O7DIYJfp84bZ4UQp8INaKngUJRG2
         5t7hC93ydBmLx6hZymhkyAJ8z6hzslWvpcEZ4NpPko+S/33nJ/XwnAYXl/PIvIOmw7hT
         WerzV63r/NymwxpqKrGb7Hxsz2B9TpJ9SD+6SR9u1geYtK02kpcWOf2S4fip82baIRUJ
         Y6hcXr60KS3/lWhCyWw3kTC4qQxN5LXTMobeqo0nD1q3Fx9GKYoYxYsUju9bbmMMMcO+
         SqYg==
X-Gm-Message-State: AO0yUKW7aQUFgcgQ5AJLUbbScbAK6/iwdDjhq3gwMzDa7PIjcjHG5gKZ
        Hsq3ru17vNn4xVqTJ7osm1D25Q==
X-Google-Smtp-Source: AK7set+gB8I7SsaibW3tqxP2qGOehyGAfE7YysBkVatv5LZKtMsvyz4C6ypUP2jUhOysRHv/ioF2JQ==
X-Received: by 2002:a05:622a:11c3:b0:3ab:d932:6c4e with SMTP id n3-20020a05622a11c300b003abd9326c4emr28225693qtk.18.1676041707499;
        Fri, 10 Feb 2023 07:08:27 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id d10-20020ac800ca000000b003b0b903720esm3579310qtg.13.2023.02.10.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:08:26 -0800 (PST)
Message-ID: <e60e4abcc9a4ae149844982afd65135d6e1c87b6.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH 01/10] media: Add P012 and P012M video format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 10 Feb 2023 10:08:25 -0500
In-Reply-To: <AM6PR04MB63418538B02868455752C74DE7D39@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1671071730.git.ming.qian@nxp.com>
         <dfaef3c8eb29108b1837a1959d598c8b0db63422.1671071730.git.ming.qian@nxp.com>
         <05bfc909-1ebb-b74f-dcdd-adc70dd97f3e@xs4all.nl>
         <AM6PR04MB63418538B02868455752C74DE7D39@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 30 janvier 2023 =C3=A0 08:15 +0000, Ming Qian a =C3=A9crit=C2=A0:
> > > diff --git a/include/uapi/linux/videodev2.h
> > > b/include/uapi/linux/videodev2.h index 1befd181a4cc..5448aa3b7858
> > > 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -626,12 +626,14 @@ struct v4l2_pix_format {
> > > =C2=A0 #define V4L2_PIX_FMT_NV24=C2=A0=C2=A0=C2=A0 v4l2_fourcc('N', '=
V', '2', '4') /* 24=C2=A0
> > > Y/CbCr
> > 4:4:4=C2=A0 */
> > > =C2=A0 #define V4L2_PIX_FMT_NV42=C2=A0=C2=A0=C2=A0 v4l2_fourcc('N', '=
V', '4', '2') /* 24=C2=A0
> > > Y/CrCb
> > 4:4:4=C2=A0 */
> > > =C2=A0 #define V4L2_PIX_FMT_P010=C2=A0=C2=A0=C2=A0 v4l2_fourcc('P', '=
0', '1', '0') /* 24=C2=A0
> > > Y/CbCr
> > 4:2:0 10-bit per component */
> > > +#define V4L2_PIX_FMT_P012=C2=A0=C2=A0=C2=A0 v4l2_fourcc('P', '0', '1=
', '2') /* 24=C2=A0
> > > Y/CbCr
> > 4:2:0 12-bit per component */
> > >=20
> > > =C2=A0 /* two non contiguous planes - one Y, one Cr + Cb interleaved=
=C2=A0 */
> > > =C2=A0 #define V4L2_PIX_FMT_NV12M=C2=A0=C2=A0 v4l2_fourcc('N', 'M', '=
1', '2') /* 12=C2=A0
> > > Y/CbCr
> > 4:2:0=C2=A0 */
> > > =C2=A0 #define V4L2_PIX_FMT_NV21M=C2=A0=C2=A0 v4l2_fourcc('N', 'M', '=
2', '1') /* 21=C2=A0
> > > Y/CrCb
> > 4:2:0=C2=A0 */
> > > =C2=A0 #define V4L2_PIX_FMT_NV16M=C2=A0=C2=A0 v4l2_fourcc('N', 'M', '=
1', '6') /* 16=C2=A0
> > > Y/CbCr
> > 4:2:2=C2=A0 */
> > > =C2=A0 #define V4L2_PIX_FMT_NV61M=C2=A0=C2=A0 v4l2_fourcc('N', 'M', '=
6', '1') /* 16=C2=A0
> > > Y/CrCb
> > 4:2:2=C2=A0 */
> > > +#define V4L2_PIX_FMT_P012M=C2=A0=C2=A0 v4l2_fourcc('P', 'M', '1', '2=
') /* 24=C2=A0
> > > Y/CbCr
> > 4:2:0 12-bit per component */
> >=20
> > The name of the V4L2_PIX_FMT_ defines in this series are hard to decode=
.
> >=20
> > In this case is it derived from V4L2_PIX_FMT_P010, which really should =
have
> > been named differently, but it's too late now :-(
> >=20
> > So I guess we'll stick with this naming, but it's not obvious what 'P01=
2'
> > means
> > without referring to documentation.
> >=20
> > Oh well.
> >=20
> > Regards,
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hans
>=20
> Hi Hans,
> =C2=A0=C2=A0=C2=A0 I'll update the format name, as you know,=C2=A0 the P0=
12 is following the P010,
> as they are almost the same, and the Y212 comes from gstreamer
> (GST_VIDEO_FORMAT_Y212_LE), then I did some naming like that.
> =C2=A0=C2=A0=C2=A0 I'll correct them in v2 patch.

I agree these naming are not obvious. In GStreamer, appart from the _LE par=
t,
we've had this historical tendency to just stick with Microsoft names when =
they
exist. Though Microsoft only define 10 and 16bits (P010/P016, Y210 and Y216=
). In
this case, the 12 has is derived from it.

https://learn.microsoft.com/en-us/windows/win32/medfound/10-bit-and-16-bit-=
yuv-video-formats

While P010 is very commonly seen, I don't know if Y210/Y212/Y216 is a great
idea. It is a 16bit component width version of YUYV, which as we know exist=
 in
all sort of swizzling. So the Microsoft name will be hard to extend to othe=
r
component order. My argument of keeping it this way though is that it match=
es
the other copy of pixel formats definition that exist in Linux, which is
drm_fourcc.h.

Nicolas
