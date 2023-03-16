Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4936BCCC1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCPK2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCPK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:28:04 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6138A72
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:28:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e194so1240763ybf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678962480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmunrNOy47kbAgzGKpIdR8US8gLtG2kYhZtPwZ4mKcQ=;
        b=gqv+1IiYdpmMpXDs35xVt7ONo54l5e8r8FBLTz8dOQA92eyuAa7m0LDlxpCpSHBl1q
         B0tc1+Y7dkKnWFiIdOk0R4SkXYBriXW7zi+NKvvVEP+jDMedhMJ0750ct3sq9sh55VPN
         KXUnukNE51SIojBcSvlLA4Zk9SwCYRd19MnC3feNNgyFzYW+1HziMhbbxrZAnbIQVP5+
         ZjRYrODWWDMq9+t0nR5y5IyT548GDPtv9rvcV89uVXmQ4DBbEvi3xmO2I9g0D+9Fb/yr
         nDErlDceoOcp0LqIPP1CX5kqCQI6s9AElqKmb7mGM7UzbacL4SkN/j184+THbnw5kBT6
         Ndow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmunrNOy47kbAgzGKpIdR8US8gLtG2kYhZtPwZ4mKcQ=;
        b=5ZP5n7OgB4HrDu5iiAJMs+ca2lwlAJ4hjRIxhImFrxVkoXRVQFlNlif7mDLM8vdSn5
         U2hprYDHwUZPD5Lc+2u0vdwhFKE+kBQtqTNkxh9yGPZNm9hc8R0JDU5537Qfv08ggtUg
         QncbIHlcrLa+MEtZKD5gEqReh6GYN5N3tmHeDRW3Cqq3J9bmWA/5pRMNdo6BzTNz6AY+
         qdd9DxnGM20PQlJBjl2Tf9HlPnIxw11qXFPrWfXK1ijeXpteAOxaHoB9g86XY9e+WmVT
         KntlVxP5SUanTooseDZOz6qCldtogPbgw42DoQVSDKVfIfp3sZL6wCS1dwvvD5fizepa
         3qgg==
X-Gm-Message-State: AO0yUKW1S48sBDHcpkc2DqRffFJBjYBSQfVli6GaiyDC4WnpwMNzTBw0
        tCiu9sbZKkdzShqklZH4jSx3cVFF/d+jyLY9Ynvrag==
X-Google-Smtp-Source: AK7set/fpuN4AOb5aootCfmdKrkXiUGVbZf7yGt+Hk/7nJzGlEd2yMbP8z3qM84sBmoMIWcG9fZC3/fEBN973EUCQoE=
X-Received: by 2002:a25:9c43:0:b0:94a:ebba:cba6 with SMTP id
 x3-20020a259c43000000b0094aebbacba6mr22207518ybo.9.1678962480315; Thu, 16 Mar
 2023 03:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221115121237.28361-2-quic_vboma@quicinc.com>
 <20230202064712.5804-1-quic_vboma@quicinc.com> <20230202064712.5804-2-quic_vboma@quicinc.com>
 <CAA8EJpqp7D3kBwPNNtdWHPdp=N+VZ_7dZEB7+O7nMxT44ZJ-5w@mail.gmail.com> <SJ0PR02MB8848889A6832306A56E42BBA85D79@SJ0PR02MB8848.namprd02.prod.outlook.com>
In-Reply-To: <SJ0PR02MB8848889A6832306A56E42BBA85D79@SJ0PR02MB8848.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Mar 2023 12:27:49 +0200
Message-ID: <CAA8EJpocJYGgw1MJs-s4QiLRuqEr51Exop+MhfHX=+K7_qSq4g@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] venus: Enable sufficient sequence change support
 for sc7180 and fix for Decoder STOP command issue.
To:     "Viswanath Boma (Temp)" <vboma@qti.qualcomm.com>
Cc:     "Viswanath Boma (Temp) (QUIC)" <quic_vboma@quicinc.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023 at 06:24, Viswanath Boma (Temp)
<vboma@qti.qualcomm.com> wrote:
>
>
> Will ensure more on V3 patch if any comments from Stan/Vikash .
> Thanks,
> viswanath

Please fix your email configuration. Top-posting is generally frowned
upon. All the headers bellow are frowned upon too.

> -----Original Message-----
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Sent: Thursday, February 2, 2023 3:41 PM
> To: Viswanath Boma (Temp) (QUIC) <quic_vboma@quicinc.com>
> Cc: stanimir.varbanov@linaro.org; Vikash Garodia (QUIC) <quic_vgarodia@qu=
icinc.com>; Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Kon=
rad Dybcio <konrad.dybcio@linaro.org>; Mauro Carvalho Chehab <mchehab@kerne=
l.org>; linux-media@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Vikash Garodia <vgarodia@qti.qualcomm.com>
> Subject: Re: [PATCH V2 1/1] venus: Enable sufficient sequence change supp=
ort for sc7180 and fix for Decoder STOP command issue.
>
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f any links or attachments, and do not enable macros.
>
> On Thu, 2 Feb 2023 at 08:47, <quic_vboma@quicinc.com> wrote:
> >
> > From: Viswanath Boma <quic_vboma@quicinc.com>
> >
> > For VP9 bitstreams, there could be a change in resolution at
> > interframe, for driver to get notified of such resolution change,
> > enable the property in video firmware.
> > Also, EOS handling is now made same in video firmware across all V6
> > SOCs, hence above a certain firmware version, the driver handling is
> > made generic for all V6s
> >
> > Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
> > Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> > Tested-by: Nathan Hebert <nhebert@chromium.org>
> > ---
> >  drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
> >  drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
> >  drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
> >  drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
> >  drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
> >  5 files changed, 41 insertions(+), 3 deletions(-)
>
> Several generic comments:
> - Please move your work on top of the recent kernels. 5.15 was released h=
alf of the year ago. I'm not going to mention 5.4 age.
> - Please split your patch into smaller logical patches.
> [vboma]
> >> As per the current client environment working on 5.15 kernel and the s=
ame changes were also ensured on 5.4 .
> >> Current changes related bringing up the utility functions to fix coupl=
e of bugs on latest firmware versions.
> >> In future , As sugggested will split the changes if they can be isolat=
ed as smaller meaningful part .

UGH. This looks like a third level quotation, not like your reply.
Could you please spend some time and fix your email client? It is
close to impossible to notice your replies otherwise.

Were these changes validated on top of linux-master or linux-next? If
not, please go ahead and validate them before sending the next patch
revision.


> >
> > diff --git a/drivers/media/platform/qcom/venus/core.h
> > b/drivers/media/platform/qcom/venus/core.h
> > index 32551c2602a9..8f94d795cc2b 100644
> > --- a/drivers/media/platform/qcom/venus/core.h
> > +++ b/drivers/media/platform/qcom/venus/core.h
> > @@ -202,6 +202,11 @@ struct venus_core {
> >         unsigned int core0_usage_count;
> >         unsigned int core1_usage_count;
> >         struct dentry *root;
> > +       struct venus_img_version {
> > +               u32 major;
> > +               u32 minor;
> > +               u32 rev;
> > +       } venus_ver;
> >  };
> >
> >  struct vdec_controls {
> > @@ -500,4 +505,17 @@ venus_caps_by_codec(struct venus_core *core, u32 c=
odec, u32 domain)
> >         return NULL;
> >  }
> >
> > +static inline int
> > +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor,
> > +u32 vrev) {
> > +       return ((core)->venus_ver.major =3D=3D vmajor && (core)->venus_=
ver.minor =3D=3D
> > +               vminor && (core)->venus_ver.rev >=3D vrev);
>
> Please make the indentation logical here (and below).
> Also is 5.6.1 (e.g.) newer than 5.4.51? Or 5.4.1 newer than 4.2.0?
> [vboma]
> >> Expected one more indent to right ? will ensure .

Expected is to have the indentation logical. Saying if ((major =3D=3D A)
&& (minor =3D=3D
B)) is not logical.

A good (and easier to comprehend) example might be:

if ((major =3D=3D A) &&
    (minor =3D=3D B)) {
}

> >> These versions check related to major/minor versions of the Firmware r=
eleases to address the mentioned issues and also if any role back preserves=
 the older behavior.
>
> > +}
> > +
> > +static inline int
> > +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor,
> > +u32 vrev) {
> > +       return ((core)->venus_ver.major =3D=3D vmajor && (core)->venus_=
ver.minor =3D=3D
> > +               vminor && (core)->venus_ver.rev <=3D vrev); }
> >  #endif
> > diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c
> > b/drivers/media/platform/qcom/venus/hfi_cmds.c
> > index 930b743f225e..e2539b58340f 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> > +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> > @@ -521,6 +521,7 @@ static int pkt_session_set_property_1x(struct hfi_s=
ession_set_property_pkt *pkt,
> >                 pkt->shdr.hdr.size +=3D sizeof(u32) + sizeof(*en);
> >                 break;
> >         }
> > +       case HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT:
> >         case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER: {
> >                 struct hfi_enable *in =3D pdata;
> >                 struct hfi_enable *en =3D prop_data; diff --git
> > a/drivers/media/platform/qcom/venus/hfi_helper.h
> > b/drivers/media/platform/qcom/venus/hfi_helper.h
> > index d2d6719a2ba4..20516b4361d3 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> > +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> > @@ -469,6 +469,8 @@
> >  #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH                 0x10030=
07
> >  #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT                     0x10030=
09
> >  #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE                   0x10030=
0a
> > +#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
> > +
> > +0x0100300b
> >
> >  /*
> >   * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
> > diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c
> > b/drivers/media/platform/qcom/venus/hfi_msgs.c
> > index df96db3761a7..07ac0fcd2852 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> > +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> > @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core
> > *core, struct venus_inst *inst,  }
> >
> >  static void
> > -sys_get_prop_image_version(struct device *dev,
> > +sys_get_prop_image_version(struct venus_core *core,
> >                            struct hfi_msg_sys_property_info_pkt *pkt)
> > {
> > +       struct device *dev =3D core->dev;
> >         u8 *smem_tbl_ptr;
> >         u8 *img_ver;
> >         int req_bytes;
> > @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
> >                 return;
> >
> >         img_ver =3D pkt->data;
> > +       if (IS_V4(core))
> > +               sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
> > +                      &core->venus_ver.major, &core->venus_ver.minor, =
&core->venus_ver.rev);
> > +       else if (IS_V6(core))
> > +               sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
> > +                      &core->venus_ver.major, &core->venus_ver.minor,
> > + &core->venus_ver.rev);
>
> What about older (V1/V3) cores?
> [vboma]
> >> Older cores not having these issues , hence as required  V4 and V6 wer=
e handled as per Current client issues.

There are no clients here and no client issues. If you are handling
parsing versions, please make it work for all supported devices.

>
> >
> >         dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
> >
> > @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct
> > venus_core *core,
> >
> >         switch (pkt->property) {
> >         case HFI_PROPERTY_SYS_IMAGE_VERSION:
> > -               sys_get_prop_image_version(dev, pkt);
> > +               sys_get_prop_image_version(core, pkt);
> >                 break;
> >         default:
> >                 dev_dbg(dev, VDBGL "unknown property data\n"); diff
> > --git a/drivers/media/platform/qcom/venus/vdec.c
> > b/drivers/media/platform/qcom/venus/vdec.c
> > index 4ceaba37e2e5..36c88858ea9d 100644
> > --- a/drivers/media/platform/qcom/venus/vdec.c
> > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh,
> > struct v4l2_decoder_cmd *cmd)
> >
> >                 fdata.buffer_type =3D HFI_BUFFER_INPUT;
> >                 fdata.flags |=3D HFI_BUFFERFLAG_EOS;
> > -               if (IS_V6(inst->core))
> > +               if (IS_V6(inst->core) &&
> > + is_fw_rev_or_older(inst->core, 1, 0, 87))
> >                         fdata.device_addr =3D 0;
> >                 else
> >                         fdata.device_addr =3D 0xdeadb000; @@ -671,6
> > +671,16 @@ static int vdec_set_properties(struct venus_inst *inst)
> >                         return ret;
> >         }
> >
> > +       /* Enabling sufficient sequence change support for VP9 */
> > +       if (of_device_is_compatible(inst->core->dev->of_node,
> > + "qcom,sc7180-venus")) {
>
> Do newer chips support this property? Do you intend to list all of them h=
ere?
> [vboma]
> >> Basing on capability of the valid chipset vs firmware support ,current=
 changes were added .

Are there any other chipsets using 5.4 firmware. If they are, are you
going to list them here? If not, you can skip the
of_device_is_compatible and just check for fw 5.4

>
> > +               if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
> > +                       ptype =3D HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFIC=
IENT_SEQCHANGE_EVENT;
> > +                       ret =3D hfi_session_set_property(inst, ptype, &=
en);
> > +                       if (ret)
> > +                               return ret;
> > +               }
> > +       }
> > +
> >         ptype =3D HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
> >         conceal =3D ctr->conceal_color & 0xffff;
> >         conceal |=3D ((ctr->conceal_color >> 16) & 0xffff) << 10;
>
>
>
> --
> With best wishes
> Dmitry



--=20
With best wishes
Dmitry
