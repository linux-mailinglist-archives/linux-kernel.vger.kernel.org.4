Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931CF740AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjF1ILI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:11:08 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55064 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232112AbjF1IG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:06:56 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S5lVX9018612;
        Wed, 28 Jun 2023 08:34:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=selector1;
 bh=PDrjMND7bGroH5j0rrcnleC0OQhYiDIbwQdzo2Jgn1U=;
 b=RtXRKS/WRZx7QSJzfVpCjRCj9ZtuaKSv3IXMctDL/yPKDmEgeo5VLF01mapnfg3LVOlU
 XtKbfby2bnY9inO/CZ0KbBRWxwmwVwtZeufo5NiNXTaPZUTeRHxOI9lwngy0TRBPVixB
 2Sn8KEsghfIKT9KJ8PrqwEMVeIp7k3LPRSCc89jmy8Nm2W0f4SJ1djae7tqZS8ny3YV5
 8AMu2qCIFVEqoYidHx70QY7trwnVn4YgezH3lLvN6X+8Y2hUw2uCh9eESZ2KY0ImE2WE
 i4aocEfzGaL7pPAXOwe2CYsUz+8kRv6z8iQxfGYjnWI3/IglynWMp0w0Z/RLYRZt5h+5 qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rgf1ara2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 08:34:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 18C8810005B;
        Wed, 28 Jun 2023 08:33:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0CDDF20B869;
        Wed, 28 Jun 2023 08:33:59 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 28 Jun
 2023 08:33:58 +0200
Date:   Wed, 28 Jun 2023 08:33:53 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     sun yq <yqsun1997@gmail.com>
CC:     <mchehab@kernel.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <499671216@qq.com>
Subject: Re: [PATCH] OOB read and write in mdp_prepare_buffer
Message-ID: <20230628063353.GA3625616@gnbcxd0016.gnb.st.com>
Mail-Followup-To: sun yq <yqsun1997@gmail.com>, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 499671216@qq.com
References: <20230627082731.1769620-1-yqsun1997@gmail.com>
 <20230627140640.GA3605278@gnbcxd0016.gnb.st.com>
 <CAA0BgY_Lj+hQdevrgK8y=wLztddnh+npP-hWz_XaPbi-5mzwnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA0BgY_Lj+hQdevrgK8y=wLztddnh+npP-hWz_XaPbi-5mzwnQ@mail.gmail.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_03,2023-06-27_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 28, 2023 at 07:28:54AM +0800, sun yq wrote:
> Hi,
> Because there are many functions using the plane, increasing the max
> number of the plane is to maximize the solution to all possible oob
> places.

I don't think it is the right approach then.  If the HW is only handling
3 planes, there should be no reason to have to allocate for 8 planes.  I
suspect that this 8 value is coming from the maximum allowed plane
number in V4L2 right ?
INHO driver should simply be fixed to ensure that num_plane won't go
higher than the real number of plane allocated in the structures.
It should be possible to get the num_plane value from the format
selected.

Alain

> 
> On Tue, Jun 27, 2023 at 10:06 PM Alain Volmat <alain.volmat@foss.st.com> wrote:
> >
> > Hi,
> >
> > On Tue, Jun 27, 2023 at 04:27:31PM +0800, yqsun1997@gmail.com wrote:
> > > From: yqsun1997 <yqsun1997@gmail.com>
> > >
> > > Because format in struct img_image_buffer max index is IMG_MAX_PLANES ==3,
> > > The num_planes max index is 8.so will be OOB like in mdp_prepare_buffer.
> >
> > Similarly as your other patch, could you describe why you need to
> > increase the IMG_MAX_PLANES while I suspect your driver only needs to
> > deal with 3 planes.  While the maximum num_planes value that can be
> > given by the user is 8, this has to be first compared to the configured
> > format prior to reaching this function.
> >
> > >
> > > static void mdp_prepare_buffer(struct img_image_buffer *b,
> > >                                struct mdp_frame *frame, struct vb2_buffer *vb)
> > > {
> > >         struct v4l2_pix_format_mplane *pix_mp = &frame->format.fmt.pix_mp;
> > >         unsigned int i;
> > >
> > >         b->format.colorformat = frame->mdp_fmt->mdp_color;
> > >         b->format.ycbcr_prof = frame->ycbcr_prof;
> > >         for (i = 0; i < pix_mp->num_planes; ++i) {
> > >                 u32 stride = mdp_fmt_get_stride(frame->mdp_fmt,
> > >                         pix_mp->plane_fmt[i].bytesperline, i);
> > >
> > >                 b->format.plane_fmt[i].stride = stride;  //oob
> > >                 ......
> > >
> > > Signed-off-by: yqsun1997 <yqsun1997@gmail.com>
> > > ---
> > >  drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> > > index ae0396806..e2e991a34 100644
> > > --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> > > +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
> > > @@ -11,7 +11,7 @@
> > >
> > >  #define IMG_MAX_HW_INPUTS    3
> > >  #define IMG_MAX_HW_OUTPUTS   4
> > > -#define IMG_MAX_PLANES               3
> > > +#define IMG_MAX_PLANES               8
> > >  #define IMG_MAX_COMPONENTS   20
> > >
> > >  struct img_crop {
> > > --
> > > 2.39.2
> > >
> >
> > Regards,
> > Alain
