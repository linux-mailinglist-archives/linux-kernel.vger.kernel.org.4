Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC162FB80
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbiKRRVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242515AbiKRRVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:21:07 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBF22F03B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:21:02 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kt23so14619000ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JzroJqAv3M6sf8fzH1HhvWkLLcpsOU2xXGPSmtWKfqU=;
        b=Zqzd+ZrMp02NE2FL9eOGW+OVCzFu2SuqncS9QeRfLERKvTjjlYyVEIzlUCHj8wpgZQ
         05EHgWRJr1qQSqOQ9eb2vyu6KYSMyrNeM8OTxpwfo8o03tKRdx5N2PM6Gi7tZvfZU5vD
         3cJA+vT8viVgreZgiUXUztG870WZ3zgzkX8SBxfqH/ahDdi9fU97PaFzBfw0hjNHyEsA
         rT0YJuCtIU4knPRLfshSOM1BUmJmAbDV98zwv3zWWWGQAa6yz/3j+TNq0W8cILywnOMJ
         xizwHZNsTd8k88TSuSGb1iRK2TLsq4EBcNd5YLpELFn7kchD26kuOJ7au/t+a1yzGJno
         OosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzroJqAv3M6sf8fzH1HhvWkLLcpsOU2xXGPSmtWKfqU=;
        b=MwmwTdP/fKvgCd+nxAHPpCHnCSvpbFdug97U3l17xA/Z0HpvLO9B4prlkgrsRb6D30
         2D37DPSXGnu3oHeJoNq/u6cF59rEMqB9D1mAy3iJIIF+qImhwTAdVZlavRc9xP885iJP
         eFuLMkJsEdMICZeBXCrSf+cjpFSvmA2plTVKVUsGGXZVApaBWe2YUCuDM2qPa8mNjlyI
         XA2Bo60ehQjqmlejh5W2qdFXqjxQ9yTXdiViG1beqbEAbzOgLsRVyMF63rPCOfk/ZUPy
         5+eclW2vvSMTz7qzILHxjE235NIn4ivRaTMtSyoHSTSvXEFsvfu/NWO8QNTMFlMkYbfB
         UPZQ==
X-Gm-Message-State: ANoB5pkNEfr4tSrHEvcgckCNVA9lOaTBPB7eUSYm2NNH2zUcW7HQOa6W
        SrhdG2qeeI0MlPTh1KFLdwzTxmRoT4+hCCayffJLiQ==
X-Google-Smtp-Source: AA0mqf4WFCPNljwJkRycjcBwNdwQzGAkw/qXvy3oH+d5RnEdM++hSTjzA2532WCZ4OwMfdU7NRf7P5g0nxMEkkhmna4=
X-Received: by 2002:a17:906:2650:b0:7b2:c004:55fe with SMTP id
 i16-20020a170906265000b007b2c00455femr2471380ejc.742.1668792060796; Fri, 18
 Nov 2022 09:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20221118084244.199909-1-umang.jain@ideasonboard.com>
 <20221118084244.199909-2-umang.jain@ideasonboard.com> <166876686476.50677.13666680068580068271@Monstersaurus>
In-Reply-To: <166876686476.50677.13666680068580068271@Monstersaurus>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 18 Nov 2022 17:20:45 +0000
Message-ID: <CAPY8ntAAYzYtESJpBBN0FPni178qjBn2x8-g0h1ROqzBXvzF9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Revert "staging: mmal-vchiq: Avoid use of bool in structures"
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang & Kieran

On Fri, 18 Nov 2022 at 10:21, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Quoting Umang Jain (2022-11-18 08:42:42)
> > This reverts commit 640e77466e69d9c28de227bc76881f5501f532ca.
> >
> > In commit 7967656ffbfa ("coding-style: Clarify the expectations around
> > bool") the check to dis-allow bool structure members was removed from
> > checkpatch.pl. It promotes bool structure members to store boolean
> > values. This enhances code readability.
> >
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>
> Thanks,
>
> That's a more direct revert of 640e77466e69 ("staging: mmal-vchiq: Avoid
> use of bool in structures") indeed.
>
> I see Stefan was concerned about clarifying that this won't affect
> firmware or userspace, it may still be good to hear from Dave to
> confirm, but my understanding of 640e77466e69, means I believe this is
> safe. I don't expect this structure to be used as any kind of ABI to
> firmware or userspace.

If it were one of the structs in one of the mmal-msh*.h files, then
I'd worry about the firmware ABI. This is internal state solely on the
kernel side so it's fine.

> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

>
> > ---
> >  .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c    | 12 ++++++------
> >  .../staging/vc04_services/vchiq-mmal/mmal-vchiq.h    |  4 ++--
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > index cb921c94996a..4abb6178cb9f 100644
> > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > @@ -863,9 +863,9 @@ static int port_info_get(struct vchiq_mmal_instance *instance,
> >                 goto release_msg;
> >
> >         if (rmsg->u.port_info_get_reply.port.is_enabled == 0)
> > -               port->enabled = 0;
> > +               port->enabled = false;
> >         else
> > -               port->enabled = 1;
> > +               port->enabled = true;
> >
> >         /* copy the values out of the message */
> >         port->handle = rmsg->u.port_info_get_reply.port_handle;
> > @@ -1304,7 +1304,7 @@ static int port_disable(struct vchiq_mmal_instance *instance,
> >         if (!port->enabled)
> >                 return 0;
> >
> > -       port->enabled = 0;
> > +       port->enabled = false;
> >
> >         ret = port_action_port(instance, port,
> >                                MMAL_MSG_PORT_ACTION_TYPE_DISABLE);
> > @@ -1359,7 +1359,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
> >         if (ret)
> >                 goto done;
> >
> > -       port->enabled = 1;
> > +       port->enabled = true;
> >
> >         if (port->buffer_cb) {
> >                 /* send buffer headers to videocore */
> > @@ -1531,7 +1531,7 @@ int vchiq_mmal_port_connect_tunnel(struct vchiq_mmal_instance *instance,
> >                         pr_err("failed disconnecting src port\n");
> >                         goto release_unlock;
> >                 }
> > -               src->connected->enabled = 0;
> > +               src->connected->enabled = false;
> >                 src->connected = NULL;
> >         }
> >
> > @@ -1799,7 +1799,7 @@ int vchiq_mmal_component_disable(struct vchiq_mmal_instance *instance,
> >
> >         ret = disable_component(instance, component);
> >         if (ret == 0)
> > -               component->enabled = 0;
> > +               component->enabled = false;
> >
> >         mutex_unlock(&instance->vchiq_mutex);
> >
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > index 6006e29232b3..6d984cf5a83a 100644
> > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > @@ -48,7 +48,7 @@ typedef void (*vchiq_mmal_buffer_cb)(
> >                 int status, struct mmal_buffer *buffer);
> >
> >  struct vchiq_mmal_port {
> > -       u32 enabled:1;
> > +       bool enabled;
> >         u32 handle;
> >         u32 type; /* port type, cached to use on port info set */
> >         u32 index; /* port index, cached to use on port info set */
> > @@ -83,7 +83,7 @@ struct vchiq_mmal_port {
> >
> >  struct vchiq_mmal_component {
> >         u32 in_use:1;
> > -       u32 enabled:1;
> > +       bool enabled;
> >         u32 handle;  /* VideoCore handle for component */
> >         u32 inputs;  /* Number of input ports */
> >         u32 outputs; /* Number of output ports */
> > --
> > 2.38.1
> >
