Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BE75F67C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiJFNWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJFNWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:22:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE239DD9F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:22:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so4355256pjs.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0J5p0MbR2bEpUCfICH6xdp5imi0dLtMRyP6mnTPI/+k=;
        b=dxX2F4zyYa1xRChIHhPTrKdOCGEqOGa0lb+en2rudcFgWZ8diAttoWVlpS8P5RFk2q
         6EHe7Y3j30qgW+BWugJp2fVOsDkr3oQvdRmf8FXCjXwVUSP2XMRyl/r3QZUa1zdVpKyd
         W1rSt16irT5exqf6zdlGdrdpouTJUCjaVIXezMgqxSkTB6JPcGSAFSOQg8PDdG9GZvyx
         Sc6FjhliCoFU9scQLK/w0TqrBIJN9oTiAHvnBvnI7jdTqGmRKQEY6/iSPFaDGpuZK6xa
         XN9EO5BdE3ZCY+TC3605f3H3zUkoJtA/5/6HXI5mk/9dKnFdwb9m9fQn0OjuYvb6oI4U
         G7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0J5p0MbR2bEpUCfICH6xdp5imi0dLtMRyP6mnTPI/+k=;
        b=itAsBRWUCTcw42KgDBb1IU0AgfNJO/DNKr2Iojdj7OeX+xvGIm5gInvPMKBcmV0egM
         qo5jgpAMsrS1NcGRMnvVdb8aEVPWthvxdpmQgt2PS8Bzn/IcCdjhkojAxz1jgKx4u7Jp
         yaryAlpj5s/DCz7vn2uKPLDR/I4uLP3WfqNRGDzpy27Ldxx0Vd40gz9Qo9OMtyp17okO
         JrnC3prXow+ztsB58DR0jkcUg2IEhECIexuo2/6jq6qmua/iPBpIbE5zE6WjKQxWY7Oi
         1gfQUEWAyB8acUnMZtfwGuAO00dE11yTjytzyfaIZPOGk2J5ly3rfiPT+TW6xPc5a2gc
         Ow0w==
X-Gm-Message-State: ACrzQf0Wq8Uo0Wa57hgdD7wY0IHmY6U3KSGLEiNs8tajtnnMbaROVBp0
        Zwyc4ZZo3WhRCuph7k5u5EDMQuLuKEtU+cMLHAyenA==
X-Google-Smtp-Source: AMsMyM6v2weV/Fdu3N0Bh6wAO2lrR1bMLaSlCLlNSbj8E6HaaXQrDXazFUiH4q0I1rXy6ekFB4TZ40s1/xO4X/uDcNA=
X-Received: by 2002:a17:90b:4b4b:b0:20a:926f:3c2e with SMTP id
 mi11-20020a17090b4b4b00b0020a926f3c2emr5136641pjb.87.1665062570526; Thu, 06
 Oct 2022 06:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220809223401.24599-1-mike.leach@linaro.org> <20220809223401.24599-14-mike.leach@linaro.org>
 <231e1e51-ab6c-2084-bb97-0594eb5fcbad@arm.com>
In-Reply-To: <231e1e51-ab6c-2084-bb97-0594eb5fcbad@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 6 Oct 2022 14:22:38 +0100
Message-ID: <CAJ9a7VjNpfbMCJppfD=hy=0dBrMpWcZ=gfKH0PQ8-mR8yUAjPQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] coresight: trace-id: Add debug & test macros to
 Trace ID allocation
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 at 12:06, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 09/08/2022 23:34, Mike Leach wrote:
> > Adds in a number of pr_debug macros to allow the debugging and test of
> > the trace ID allocation system.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-trace-id.c  | 36 +++++++++++++++++++
> >   1 file changed, 36 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> > index ac9092896dec..24c19ff493a9 100644
> > --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> > @@ -69,6 +69,30 @@ static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_ma
> >       set_bit(id, id_map->pend_rel_ids);
> >   }
> >
> > +/* #define TRACE_ID_DEBUG 1 */
> > +#ifdef TRACE_ID_DEBUG
> > +static char page_buf[PAGE_SIZE];
> > +
> > +static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
> > +                                       const char *func_name)
> > +{
> > +     pr_debug("%s id_map::\n", func_name);
> > +     bitmap_print_to_pagebuf(0, page_buf, id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
> > +     pr_debug("Avial= %s\n", page_buf);
>
> Could we not use %pb directly and skip the bitmap_print_to_pagebuf  ?
>
> Suzuki

In short, yes!

Mike


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
