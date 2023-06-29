Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B17A7426B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjF2MtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjF2MtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:49:10 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EE21FD8;
        Thu, 29 Jun 2023 05:49:08 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4717089ae5bso240095e0c.0;
        Thu, 29 Jun 2023 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688042947; x=1690634947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vibqGgTSkZNI78S50QxrbWxjy/o83ic28jzcG95Wy2Q=;
        b=P3EPMDYmvOSSNO9IpZqusoOBhARr6/ZEj3M9vLeC2NLXktdqWrxRP6VCiBJB2OfVNO
         poEVY6xEQCXTliwFgS7PtM5HIu6UcG9AeFUQT9d3+0PK1E8f5g3lD/9H8L8gZ3jvqgyq
         E3MATdkd4sCHDdQIL8RznP6cNlvtmN34rMtE+aUmE7aDTLDM+xoyod8fJ+HpUMWjmc7C
         LDWLNoZa81W3LdFza0scs6+quKYp5DrvUtWbvDybN9e4w5ER1pqgVhtpQ2KQt0cq84to
         eh+Ot6kJKqTWzN1RoCAGL6YJsKiOw2Cjut2vNti/xl6r2ofFasHqv0v7msfHvoyhYpxE
         JIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042947; x=1690634947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vibqGgTSkZNI78S50QxrbWxjy/o83ic28jzcG95Wy2Q=;
        b=XJr369u5Yr2eVqs1qAc4UNjYY4jo//0GoQCdb1rKN7ZloVB7r74ZqtmViZ65u8xGoK
         RiycA+zo633XJhI7Jw1u8wbc1OJGwBow5Ln9WtXOMOGYT5c1f5aX/vxjxQqZQEi63hjN
         /eWd6HPevbi3b6uzY3LokG/1zPsmdnvPLufLcbCxlwHTIVyv0wyp54ksDwc/15cL4nMK
         ny5kwhHT8TWk0t+R070oBzYO9rvgVxkLjcGXnLJAFjhXyaoPSwrsiNtkgPjSRFHXup0H
         H9z4kfkSICKgoa4zgdAbqvnhA+XW+WFrN7O9R/x19Ry/redTrp16Yk1MukaMhXPR7N1c
         yvTw==
X-Gm-Message-State: AC+VfDx7gT4j243fUkQZe3G6hYDAjpwHxiWV+MUVrPG1ppKAmDwrrRwo
        YoIQ3VpCzevqrz7em2PPRy3Eq0hiJ1NUZOoOqts=
X-Google-Smtp-Source: ACHHUZ7Imuyy+vaxv6ag//M1MbImCVZ/QGl59+QnilJ6V+R09MX3TvxgWSai1hFKtmimL+klvWeZki159QVoEgIick8=
X-Received: by 2002:a1f:c1c3:0:b0:471:5224:bbdf with SMTP id
 r186-20020a1fc1c3000000b004715224bbdfmr19495635vkf.3.1688042947552; Thu, 29
 Jun 2023 05:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230502084430.234182-1-milkfafa@gmail.com> <20230502084430.234182-8-milkfafa@gmail.com>
 <e43029b5-edbb-9358-a0a6-a104ff2fa154@xs4all.nl>
In-Reply-To: <e43029b5-edbb-9358-a0a6-a104ff2fa154@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 29 Jun 2023 20:48:56 +0800
Message-ID: <CADnNmFpSg+nU+gvc-CUzYRJ6newCrgLesoLda6kHJ6o2a8Su5A@mail.gmail.com>
Subject: Re: [PATCH v12 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     mchehab@kernel.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrzej.p@collabora.com,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

> Apologies for the delay in reviewing this. As you may have noticed, we
> have too many incoming patches and not enough reviewers, so it takes
> too often way too long before I have time to review drivers like this.

That's OK. I appreciate your time and comments.

> > +     /* Resolution changed */
> > +     if (status & VCD_STAT_VHT_CHG || status & VCD_STAT_HAC_CHG)
> > +             schedule_work(&video->res_work);
>
> I don't think you need to schedule work. If the resolution changed,
> then you can just call vb2_queue_error and queue the SOURCE_CHANGED
> event here. You don't need to detect the resolution, you know it has changed,
> so just inform userspace and that will call QUERY_DV_TIMINGS.

OK. Will modify it as you suggested.

> > +     if (status & VCD_STAT_IFOR || status & VCD_STAT_IFOT) {
> > +             dev_warn(video->dev, "VCD FIFO overrun or over thresholds\n");
> > +             npcm_video_stop(video);
> > +             npcm_video_start(video);
>
> This is dangerous: video_start detects the resolution and can update the
> width/height. So now there can be a mismatch between what userspace expects
> and what the DMA sends.
>
> I would make a new npcm_video_init(video) function that does the initial
> timings detection. Call that on the first open. The npcm_video_start drops
> that code and just uses the last set timings.
>
> Feel free to use an alternative to this, as long as restarting the video
> here doesn't change the width/height/format as a side-effect.

Understood. I've checked that it can just call npcm_video_start_frame (in which
npcm_video_vcd_state_machine_reset will be called to reset VCD state
machine and FIFOs) and
the width/height/format will not be changed.

> > +     if (*num_buffers > MAX_REQ_BUFS)
> > +             *num_buffers = MAX_REQ_BUFS;
>
> Why limit this? Can't you just use rect[VIDEO_MAX_FRAME]?

I just realized VIDEO_MAX_FRAME is a common define in videodev2.h.
Will change to use it.

> > +     /*
> > +      * When a video buffer is dequeued, free associated rect_list and
> > +      * capture next frame.
> > +      */
> > +     head = &video->list[video->vb_index];
> > +     list_for_each_safe(pos, nx, head) {
> > +             tmp = list_entry(pos, struct rect_list, list);
> > +             list_del(&tmp->list);
> > +             kfree(tmp);
> > +     }
> > +
> > +     if (npcm_video_start_frame(video)) {
>
> This is weird. This is not normally done here since you never know when
> userspace will dequeue a buffer.
>
> I would expect to see this called:
>
> 1) In start_streaming (so that works)
> 2) When a buffer is captured and vb2_buffer_done is called: if another
>    empty buffer is available, then use that.
> 3) in buf_queue: if the buffer list was empty, and vb2_start_streaming_called()
>    is true, then you can start capturing again.

Will modify as you suggested. Thanks for the guide.

Regards,
Marvin
