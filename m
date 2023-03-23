Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711E56C6D37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCWQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCWQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:18:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0346F13524
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:18:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 20so15970925lju.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679588300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSTISpeEnDJPqAU6jSux3fWpEzcIJpR2kNb4sJooRtU=;
        b=CsCdxwtLtLl+i5n0KdQlyTY18IXjPLHbpvytAcFp+pEHHq1yHZRER503+zxPCMjOZN
         RZ7gazMfjdQDhUw1M8SESp//8JXYgFCNkTzk2Nyuqt/pg8X21JoeHl1Blb0l4OTs/+UH
         kF47yxprUegdr1abj5ZeeTuphjNEr21n+b4qWS/+R8/7/LmCJc+J2XeJZByolM/Vl6gR
         AXt74X4uLLgD64emakLB5d0hnTdmuH4gWDFNIdJ6MYAhLkgrPDXiwWj6K2RMKN8o9NCA
         NkNW4Hxt087xCrlCs9U/3+7ccO2EUxQDlWojioUXDCYBo3ZmI6Lr13KNU67NpV2pAK+j
         nYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679588300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSTISpeEnDJPqAU6jSux3fWpEzcIJpR2kNb4sJooRtU=;
        b=Kw1qd36NRhb6eIY9HZi7cQgH5qDQkH4/VsLA1LYtFGl6oagc9TC5Bj8p+drRLp62Ot
         +7M97Ju71ktnHOm/YzKOrNV2VTvkNUfYiXUrHAPTFoi3PpI0b18egqVD0fE13OijPcLm
         XQ4JviNsh16DqSrbXV0PJv822hTohDy01PyrMer9x1rdSvKeQFHWwL6OF+ZzgyyNtkV5
         BwwwrVV8ApLwT93sOIbmbIHlmsFvimF+DWIBQKI2NM9Q+gEB+fbHLDAa/Hh6myJCaATE
         CZTcc7pDcDj3INmCWE7XtROHgDGNkzLmarx+AVJbPsUZlwFfYCjwCRuWYIxTQ+jBbPCc
         i90g==
X-Gm-Message-State: AO0yUKWmT1hngOK3yeSWGs7i7uBHc1xvjw7oUyd9ALNoXnpmwTELha8N
        hR4lbsbK1Ws9xBOxn6r89eHxuQ==
X-Google-Smtp-Source: AK7set9SBP2mz7mp5AkpjXzbnYUPIgsBjfZTPHwBBmVK031Vw9WWl0S/QQ3RRQxmKj+brvIsGmr8Pg==
X-Received: by 2002:a2e:b0d7:0:b0:293:32e0:5c8a with SMTP id g23-20020a2eb0d7000000b0029332e05c8amr3388075ljl.15.1679588300715;
        Thu, 23 Mar 2023 09:18:20 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e918f000000b00298a7fcda67sm3080163ljg.97.2023.03.23.09.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 09:18:20 -0700 (PDT)
Message-ID: <30f3dc2d-67d3-6935-1efb-bf888a28987f@linaro.org>
Date:   Thu, 23 Mar 2023 17:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] venus: Enable sufficient sequence change support for
 sc7180 and fix for Decoder STOP command issue.
Content-Language: en-US
To:     "Viswanath Boma (Temp)" <vboma@qti.qualcomm.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Viswanath Boma (Temp) (QUIC)" <quic_vboma@quicinc.com>
Cc:     "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
References: <20230202064712.5804-2-quic_vboma@quicinc.com>
 <20230316081509.12201-1-quic_vboma@quicinc.com>
 <20230316081509.12201-2-quic_vboma@quicinc.com>
 <CAA8EJpozq1nCgG5npK5JUXc-Y-7LiPe3Y_VP8++Rq70AreCenA@mail.gmail.com>
 <SJ0PR02MB8848AD9F976AA962B1EA292E85879@SJ0PR02MB8848.namprd02.prod.outlook.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <SJ0PR02MB8848AD9F976AA962B1EA292E85879@SJ0PR02MB8848.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.03.2023 10:16, Viswanath Boma (Temp) wrote:
> Hi Dmirty ,
> 
> Thanks for reviews .
Please don't top-post.

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

Konrad
> 
>> -----Original Message-----
>> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Sent: Thursday, March 16, 2023 3:50 PM
>> To: Viswanath Boma (Temp) (QUIC) <quic_vboma@quicinc.com>
>> Cc: stanimir.varbanov@linaro.org; Vikash Garodia (QUIC)
>> <quic_vgarodia@quicinc.com>; Andy Gross <agross@kernel.org>;
>> bjorn.andersson@linaro.org; Konrad Dybcio <konrad.dybcio@linaro.org>;
>> Mauro Carvalho Chehab <mchehab@kernel.org>; linux-
>> media@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Vikash Garodia <vgarodia@qti.qualcomm.com>
>> Subject: Re: [PATCH] venus: Enable sufficient sequence change support for
>> sc7180 and fix for Decoder STOP command issue.
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary of
>> any links or attachments, and do not enable macros.
>>
>> On Thu, 16 Mar 2023 at 10:17, <quic_vboma@quicinc.com> wrote:
>>>
>>> From: Viswanath Boma <quic_vboma@quicinc.com>
>>>
>>> For VP9 bitstreams, there could be a change in resolution at
>>> interframe, for driver to get notified of such resolution change,
>>> enable the property in video firmware.
>>> Also, EOS handling is now made same in video firmware across all V6
>>> SOCs, hence above a certain firmware version, the driver handling is
>>> made generic for all V6s
>>>
>>> Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
>>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>>> ---
>>
>> Which version of the patch is this? Were there any changes compared to the
>> previous version? Please include a changelog below the dashed line to let other
>> people know what has changed
>>
> This is version v2 or v3 --> Keep this as per the version.
> Sure, let me fix the version and changes info in the next revision.
> 
>>>  drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
>>>  drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
>>>  drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
>>>  drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
>>>  drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
>>>  5 files changed, 41 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/core.h
>>> b/drivers/media/platform/qcom/venus/core.h
>>> index 32551c2602a9..ee8b70a34656 100644
>>> --- a/drivers/media/platform/qcom/venus/core.h
>>> +++ b/drivers/media/platform/qcom/venus/core.h
>>> @@ -202,6 +202,11 @@ struct venus_core {
>>>         unsigned int core0_usage_count;
>>>         unsigned int core1_usage_count;
>>>         struct dentry *root;
>>> +       struct venus_img_version {
>>> +               u32 major;
>>> +               u32 minor;
>>> +               u32 rev;
>>> +       } venus_ver;
>>>  };
>>>
>>>  struct vdec_controls {
>>> @@ -500,4 +505,17 @@ venus_caps_by_codec(struct venus_core *core, u32
>> codec, u32 domain)
>>>         return NULL;
>>>  }
>>>
>>> +static inline int
>>> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor,
>>> +u32 vrev) {
>>> +       return ((core)->venus_ver.major == vmajor && (core)-
>>> venus_ver.minor ==
>>> +                       vminor && (core)->venus_ver.rev >= vrev); }
>>> +
>>> +static inline int
>>> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor,
>>> +u32 vrev) {
>>> +       return ((core)->venus_ver.major == vmajor && (core)-
>>> venus_ver.minor ==
>>> +                       vminor && (core)->venus_ver.rev <= vrev); }
>>>  #endif
>>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c
>>> b/drivers/media/platform/qcom/venus/hfi_cmds.c
>>> index 930b743f225e..e2539b58340f 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
>>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
>>> @@ -521,6 +521,7 @@ static int pkt_session_set_property_1x(struct
>> hfi_session_set_property_pkt *pkt,
>>>                 pkt->shdr.hdr.size += sizeof(u32) + sizeof(*en);
>>>                 break;
>>>         }
>>> +       case
>> HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT:
>>>         case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER: {
>>>                 struct hfi_enable *in = pdata;
>>>                 struct hfi_enable *en = prop_data; diff --git
>>> a/drivers/media/platform/qcom/venus/hfi_helper.h
>>> b/drivers/media/platform/qcom/venus/hfi_helper.h
>>> index d2d6719a2ba4..20516b4361d3 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
>>> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
>>> @@ -469,6 +469,8 @@
>>>  #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH
>> 0x1003007
>>>  #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT                     0x1003009
>>>  #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE
>> 0x100300a
>>> +#define
>> HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
>>> +
>>> +0x0100300b
>>>
>>>  /*
>>>   * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
>>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> b/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> index df96db3761a7..07ac0fcd2852 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
>>> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core
>>> *core, struct venus_inst *inst,  }
>>>
>>>  static void
>>> -sys_get_prop_image_version(struct device *dev,
>>> +sys_get_prop_image_version(struct venus_core *core,
>>>                            struct hfi_msg_sys_property_info_pkt *pkt)
>>> {
>>> +       struct device *dev = core->dev;
>>>         u8 *smem_tbl_ptr;
>>>         u8 *img_ver;
>>>         int req_bytes;
>>> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>>>                 return;
>>>
>>>         img_ver = pkt->data;
>>> +       if (IS_V4(core))
>>> +               sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
>>> +                      &core->venus_ver.major, &core->venus_ver.minor, &core-
>>> venus_ver.rev);
>>> +       else if (IS_V6(core))
>>> +               sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
>>> +                      &core->venus_ver.major, &core->venus_ver.minor,
>>> + &core->venus_ver.rev);
>>>
>>>         dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>>>
>>> @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct
>>> venus_core *core,
>>>
>>>         switch (pkt->property) {
>>>         case HFI_PROPERTY_SYS_IMAGE_VERSION:
>>> -               sys_get_prop_image_version(dev, pkt);
>>> +               sys_get_prop_image_version(core, pkt);
>>>                 break;
>>>         default:
>>>                 dev_dbg(dev, VDBGL "unknown property data\n"); diff
>>> --git a/drivers/media/platform/qcom/venus/vdec.c
>>> b/drivers/media/platform/qcom/venus/vdec.c
>>> index 4ceaba37e2e5..36c88858ea9d 100644
>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>> @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh,
>>> struct v4l2_decoder_cmd *cmd)
>>>
>>>                 fdata.buffer_type = HFI_BUFFER_INPUT;
>>>                 fdata.flags |= HFI_BUFFERFLAG_EOS;
>>> -               if (IS_V6(inst->core))
>>> +               if (IS_V6(inst->core) &&
>>> + is_fw_rev_or_older(inst->core, 1, 0, 87))
>>>                         fdata.device_addr = 0;
>>>                 else
>>>                         fdata.device_addr = 0xdeadb000; @@ -671,6
>>> +671,16 @@ static int vdec_set_properties(struct venus_inst *inst)
>>>                         return ret;
>>>         }
>>>
>>> +       /* Enabling sufficient sequence change support for VP9 */
>>> +       if (of_device_is_compatible(inst->core->dev->of_node,
>>> + "qcom,sc7180-venus")) {
>>
>> Is it really specific just to sc7180 or will it be applicable to any other platform
>> using venus-5.4 firmware?
>>
>>> +               if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
>>> +                       ptype =
>> HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
>>> +                       ret = hfi_session_set_property(inst, ptype, &en);
>>> +                       if (ret)
>>> +                               return ret;
>>> +               }
>>> +       }
>>> +
>>>         ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
>>>         conceal = ctr->conceal_color & 0xffff;
>>>         conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
>>> --
>>> 2.17.1
>>>
>>
>>
>> --
>> With best wishes
>> Dmitry
