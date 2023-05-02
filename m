Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86C16F43AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjEBMWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjEBMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:22:10 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D64E5D
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:21:54 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-55a1462f9f6so24464027b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683030114; x=1685622114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v0ELEJaxmyMHE86NJZXf/OVqd45Nxv6qSnG8aCn1dms=;
        b=y6cdTbHtduWu7yW0MFh2JTL5r7bTmocpHVvi/ntHauHi9Pq1/Lwpyp0tqSH90CEmtt
         QVTGSTTKyr4dvyE/IFh4omLV7T6G3lUecQ+kbwN907BmQXh7YbYLGsqCeQyJiLuxtni7
         OoALzyjcB4WMMAz14TWrXvVgqPbWh0npyEATXdnzWwdKvog1LWYiDb4zCMA5RMrIAx0Z
         /PPzWNc01T6ShhCT9Sli1ILKVAZxRiePuqEzTPj3PEBo5fDDUvGKYnjwgFhApSWfbSYw
         WQckJYCh0p3S1VlpxWWri4cE86+1r67CZD1DtT2C4MbfIanbqPtjn2Rwohx9ackRQtkV
         a8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683030114; x=1685622114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0ELEJaxmyMHE86NJZXf/OVqd45Nxv6qSnG8aCn1dms=;
        b=kNU1+CN7dmIB1/KveACDTRFYyec8dGIMjY8lJMuUL6y8XBLuUfzTithX7JdjVb3E+o
         Yxe3OjPPcBUKrrz6kkzYz+gT7XTaerZAe/s+Bt8gXgnFKTI16lFZRNPjUKQF6X0XULJ5
         CqjcsO6gA9eqASpHQd9R0454Rxpyz8hk9khyOdYfCr4qpcTE9uyEmIrVJJFtSMQcTCi3
         aOsDOmDZPhANvJsQijmnDR2ok1rLE4UjwkWsmGsdDHzsvMadZ3aq9QlM6TvecHxwwfpg
         e+4mBFNI+B5OldfNu6mXtg9Q64aJgbnktuKJmU97j1EJeaXmETAZvUowjb1d6NNaLM4n
         +NTw==
X-Gm-Message-State: AC+VfDwfCV/3F0RiDBuZaNrPidvOZ3a181MyAtdiTpz/jiuI8l3lzif1
        VAzlXE7eTKRWajhwhdEIZF9G9XV5FcNg3z7bVQ+j+g==
X-Google-Smtp-Source: ACHHUZ54VmADvQKJKh71p0TlnN2S++HjGqYIsN12v/Jh03QvzM5HJOh/pgSCZ25PyQYThKrtg4nK0QGV68jadmQa8+Q=
X-Received: by 2002:a81:4e0b:0:b0:55a:985e:8ad1 with SMTP id
 c11-20020a814e0b000000b0055a985e8ad1mr2264034ywb.33.1683030114110; Tue, 02
 May 2023 05:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <1682492417-20496-1-git-send-email-quic_dikshita@quicinc.com> <4434859f-a5b2-a9da-8dad-3f2c4f48cd27@linaro.org>
In-Reply-To: <4434859f-a5b2-a9da-8dad-3f2c4f48cd27@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 2 May 2023 15:21:43 +0300
Message-ID: <CAA8EJprKLxeHO98TayzaS-U+O9JYvVe1zDKU+XPmrKxkQ_Sp3w@mail.gmail.com>
Subject: Re: [PATCH] venus: add support for 10 bit decoding.
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 14:53, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 26.04.2023 09:00, Dikshita Agarwal wrote:
> > - Add support for V4L2_PIX_FMT_P010 color format.
> > - Add handling of bit depth change from firmware.
> > - Return P010 as preferred format for 10 bit decode.
> Sounds like this should be 3 separate patches, preferably with
> some insight in each commit message.

Absolutely. I think there were several 'split one patch per feature'
feedbacks for the previous series.

>
> Konrad
> >
> > Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > ---
> >  drivers/media/platform/qcom/venus/helpers.c        | 25 ++++++++++++++++++++++
> >  drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |  3 +++
> >  .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |  9 +++++++-
> >  drivers/media/platform/qcom/venus/vdec.c           | 18 +++++++++++++---
> >  4 files changed, 51 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> > index ab6a29f..193215c 100644
> > --- a/drivers/media/platform/qcom/venus/helpers.c
> > +++ b/drivers/media/platform/qcom/venus/helpers.c
> > @@ -612,6 +612,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
> >               return HFI_COLOR_FORMAT_NV12_UBWC;
> >       case V4L2_PIX_FMT_QC10C:
> >               return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
> > +     case V4L2_PIX_FMT_P010:
> > +             return HFI_COLOR_FORMAT_P010;
> >       default:
> >               break;
> >       }
> > @@ -639,12 +641,16 @@ static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
> >       if (is_dec) {
> >               params.width = inst->width;
> >               params.height = inst->height;
> > +             params.out_width = inst->out_width;
> > +             params.out_height = inst->out_height;
> >               params.codec = inst->fmt_out->pixfmt;
> >               params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_cap->pixfmt);
> >               params.dec.max_mbs_per_frame = mbs_per_frame_max(inst);
> >               params.dec.buffer_size_limit = 0;
> >               params.dec.is_secondary_output =
> >                       inst->opb_buftype == HFI_BUFFER_OUTPUT2;
> > +             if (params.dec.is_secondary_output)
> > +                     params.hfi_dpb_color_fmt = inst->dpb_fmt;
> >               params.dec.is_interlaced =
> >                       inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE;
> >       } else {
> > @@ -1764,6 +1770,25 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
> >       if (!caps)
> >               return -EINVAL;
> >
> > +     if (inst->bit_depth == VIDC_BITDEPTH_10 &&
> > +         inst->session_type == VIDC_SESSION_TYPE_DEC) {
> > +             found_ubwc =
> > +                     find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
> > +                                        HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
> > +             found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2,
> > +                                        fmt);
> > +             if (found_ubwc && found) {
> > +                     /*
> > +                      * Hard-code DPB buffers to be 10bit UBWC
> > +                      * until V4L2 is able to expose compressed/tiled
> > +                      * formats to applications.
> > +                      */
> > +                     *out_fmt = HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
> > +                     *out2_fmt = fmt;
> > +                     return 0;
> > +             }
> > +     }
> > +
> >       if (ubwc) {
> >               ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
> >               found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
> > diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
> > index 52a51a3..25e6074 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
> > +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
> > @@ -12,8 +12,11 @@
> >  struct hfi_plat_buffers_params {
> >       u32 width;
> >       u32 height;
> > +     u32 out_width;
> > +     u32 out_height;
> >       u32 codec;
> >       u32 hfi_color_fmt;
> > +     u32 hfi_dpb_color_fmt;
> >       enum hfi_version version;
> >       u32 num_vpp_pipes;
> >       union {
> > diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> > index ea25c45..08caab1 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> > +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> > @@ -1185,6 +1185,7 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
> >       enum hfi_version version = params->version;
> >       u32 codec = params->codec;
> >       u32 width = params->width, height = params->height, out_min_count;
> > +     u32 out_width = params->out_width, out_height = params->out_height;
> >       struct dec_bufsize_ops *dec_ops;
> >       bool is_secondary_output = params->dec.is_secondary_output;
> >       bool is_interlaced = params->dec.is_interlaced;
> > @@ -1235,7 +1236,13 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
> >               bufreq->count_min = out_min_count;
> >               bufreq->size =
> >                       venus_helper_get_framesz_raw(params->hfi_color_fmt,
> > -                                                  width, height);
> > +                                                  out_width, out_height);
> > +
> > +             if (buftype == HFI_BUFFER_OUTPUT &&
> > +                 params->dec.is_secondary_output)
> > +                     bufreq->size =
> > +                             venus_helper_get_framesz_raw(params->hfi_dpb_color_fmt,
> > +                                                          out_width, out_height);
> >       } else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {
> >               bufreq->size = dec_ops->scratch(width, height, is_interlaced);
> >       } else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH_1(version)) {
> > diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> > index 4ceaba3..99d0e96 100644
> > --- a/drivers/media/platform/qcom/venus/vdec.c
> > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > @@ -43,6 +43,10 @@ static const struct venus_format vdec_formats[] = {
> >               .num_planes = 1,
> >               .type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> >       }, {
> > +             .pixfmt = V4L2_PIX_FMT_P010,
> > +             .num_planes = 1,
> > +             .type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> > +     }, {
> >               .pixfmt = V4L2_PIX_FMT_MPEG4,
> >               .num_planes = 1,
> >               .type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> > @@ -697,6 +701,9 @@ static int vdec_set_work_route(struct venus_inst *inst)
> >  }
> >
> >  #define is_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_UBWC_BASE))
> > +#define is_10bit_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_10_BIT_BASE & \
> > +                                 HFI_COLOR_FORMAT_UBWC_BASE))
> > +
> >
> >  static int vdec_output_conf(struct venus_inst *inst)
> >  {
> > @@ -744,7 +751,7 @@ static int vdec_output_conf(struct venus_inst *inst)
> >               inst->opb_fmt = out2_fmt;
> >               inst->dpb_buftype = HFI_BUFFER_OUTPUT;
> >               inst->dpb_fmt = out_fmt;
> > -     } else if (is_ubwc_fmt(out2_fmt)) {
> > +     } else if (is_ubwc_fmt(out2_fmt) || is_10bit_ubwc_fmt(out_fmt)) {
> >               inst->opb_buftype = HFI_BUFFER_OUTPUT;
> >               inst->opb_fmt = out_fmt;
> >               inst->dpb_buftype = HFI_BUFFER_OUTPUT2;
> > @@ -1420,7 +1427,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
> >  static void vdec_event_change(struct venus_inst *inst,
> >                             struct hfi_event_data *ev_data, bool sufficient)
> >  {
> > -     static const struct v4l2_event ev = {
> > +     struct v4l2_event ev = {
> >               .type = V4L2_EVENT_SOURCE_CHANGE,
> >               .u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION };
> >       struct device *dev = inst->core->dev_dec;
> > @@ -1461,8 +1468,13 @@ static void vdec_event_change(struct venus_inst *inst,
> >       inst->out_width = ev_data->width;
> >       inst->out_height = ev_data->height;
> >
> > -     if (inst->bit_depth != ev_data->bit_depth)
> > +     if (inst->bit_depth != ev_data->bit_depth) {
> >               inst->bit_depth = ev_data->bit_depth;
> > +             if (inst->bit_depth == VIDC_BITDEPTH_10)
> > +                     inst->fmt_cap = &vdec_formats[3];
> > +             else
> > +                     inst->fmt_cap = &vdec_formats[0];
> > +     }
> >
> >       if (inst->pic_struct != ev_data->pic_struct)
> >               inst->pic_struct = ev_data->pic_struct;



-- 
With best wishes
Dmitry
