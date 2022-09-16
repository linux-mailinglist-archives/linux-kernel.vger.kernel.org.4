Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3765BA369
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 02:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIPAEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 20:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIPAEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 20:04:06 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8855C61D61
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 17:04:05 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6ECD93F45E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663286643;
        bh=dEt9suttK6bik37ObVLfsquYHcW4B7tPX30QGwKA5II=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ah6tMDkJ1LKIgkUVGFW34dcDMlxwGJgLrFTYXzX2l7Oir9TzXZ1zZH/JCKX6E2WSY
         pEvsSgRangYQdciwPzPwKSKV58kuQ2syS+V+vCP6+uhY1KKfVcPOlxDVOeR/pLn1YJ
         RohsCbO6oOU4UUZxYHMQRYPFuRDQH4doufCmRPR+f20u9A56a1ACGiPEAuq/CPU6xz
         m+o5voOtNYmFioT24MDDarmkHnG0gIdkgQb/2G7PyTAYIuw5INv9T01Kfn68LwDGUk
         m8/p29b4vo2bt20zSwlGH4T4h3WpLC7GxkDFeQtvrt5w9v1+c8Ks5WsZvqHH3hV1Ei
         ll+u8zXA8gCXQ==
Received: by mail-wm1-f69.google.com with SMTP id p24-20020a05600c1d9800b003b4b226903dso1360147wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 17:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dEt9suttK6bik37ObVLfsquYHcW4B7tPX30QGwKA5II=;
        b=ojAV+tRFsMe6Pw1cb5hPQM4oCt+h8tOt2r1ehIjRqTtAwfhar6ajplzouQsFLosM5C
         oe19i+9qboxS8MfGugTttAbk8M3vCMAECpwybLs3J8TFJ1z2PMhYpaXdAphSZvTgWRxh
         CB/5cWL8T8mXwWdvVwevVkNnOjYkvv4orAm0BfmA6Ulu1Z/A6beFXhvbJIrTu0+GOTBg
         ZzBF2OsGaQsD7djSqaw48YWYaduSuS7WozJNgmy95RMf2gtXP6HBecV/M+ikR9vDubfu
         kQtWqy4UaCjCIAnnI7+9zsxN/TzXDnIsgzKsbxMLm4iLgukSWrb0EAqUGG4IIf6f6bU7
         7fWg==
X-Gm-Message-State: ACrzQf35nDIUy87fGRk7tTrW2z+C2rAnPu0tseR4dN05kQ3VrJHMPSaT
        WMEJWHE3dvt+c/l/OGjkYvMEwhSo/TRQfIq34fhFo9zhRd6i+cuqqkCJMBbX3fhr5G4yEMEhIrE
        C9ATn+/CdsMAaLLBDwvhDPnIfBDeVn88O1N1p16SD/AaXIaheSY2o4tt9Eg==
X-Received: by 2002:a5d:6d09:0:b0:228:d897:af3c with SMTP id e9-20020a5d6d09000000b00228d897af3cmr1289868wrq.78.1663286641819;
        Thu, 15 Sep 2022 17:04:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6TXwN3hPjyfqhOjz9Yu3dApjEc7WfflxjUkm9GzI89v5Nrm6OB4X8SP1gpyfb4xHMBhxGtE50eMjJAI4kx3TM=
X-Received: by 2002:a5d:6d09:0:b0:228:d897:af3c with SMTP id
 e9-20020a5d6d09000000b00228d897af3cmr1289857wrq.78.1663286641609; Thu, 15 Sep
 2022 17:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220913062042.1977790-1-kai.heng.feng@canonical.com> <a88168af-e072-2af6-fca4-0472d3277f68@collabora.com>
In-Reply-To: <a88168af-e072-2af6-fca4-0472d3277f68@collabora.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 16 Sep 2022 08:03:50 +0800
Message-ID: <CAAd53p7CcPfu3-=6n6vUXW8=GjC9HEh6jivAHWza5mj77i4GKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kernel/reboot: Add SYS_OFF_MODE_RESTART_PREPARE mode
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     rafael.j.wysocki@intel.com, lenb@kernel.org,
        tangmeng <tangmeng@uniontech.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:14 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 9/13/22 09:20, Kai-Heng Feng wrote:
> > Add SYS_OFF_MODE_RESTART_PREPARE callbacks can be invoked before system
> > restart.
> >
> > This is a preparation for next patch.
> >
> > Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >  - New patch.
> >
> >  include/linux/reboot.h |  8 ++++++++
> >  kernel/reboot.c        | 17 +++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> > index e5d9ef886179c..ba87cdef2335a 100644
> > --- a/include/linux/reboot.h
> > +++ b/include/linux/reboot.h
> > @@ -105,6 +105,14 @@ enum sys_off_mode {
> >        */
> >       SYS_OFF_MODE_POWER_OFF,
> >
> > +     /**
> > +      * @SYS_OFF_MODE_RESTART_PREPARE:
> > +      *
> > +      * Handlers prepare system to be powered off. Handlers are
>
> s/powered off/restarted/

Will address this in next revision.

Kai-Heng

>
> > +      * allowed to sleep.
> > +      */
> > +     SYS_OFF_MODE_RESTART_PREPARE,
> > +
> >       /**
> >        * @SYS_OFF_MODE_RESTART:
> >        *
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index 3c35445bf5ad3..3bba88c7ffc6b 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -243,6 +243,17 @@ void migrate_to_reboot_cpu(void)
> >       set_cpus_allowed_ptr(current, cpumask_of(cpu));
> >  }
> >
> > +/*
> > + *   Notifier list for kernel code which wants to be called
> > + *   to prepare system for restart.
> > + */
> > +static BLOCKING_NOTIFIER_HEAD(restart_prep_handler_list);
> > +
> > +static void do_kernel_restart_prepare(void)
> > +{
> > +     blocking_notifier_call_chain(&restart_prep_handler_list, 0, NULL);
> > +}
> > +
> >  /**
> >   *   kernel_restart - reboot the system
> >   *   @cmd: pointer to buffer containing command to execute for restart
> > @@ -254,6 +265,7 @@ void migrate_to_reboot_cpu(void)
> >  void kernel_restart(char *cmd)
> >  {
> >       kernel_restart_prepare(cmd);
> > +     do_kernel_restart_prepare();
> >       migrate_to_reboot_cpu();
> >       syscore_shutdown();
> >       if (!cmd)
> > @@ -396,6 +408,11 @@ register_sys_off_handler(enum sys_off_mode mode,
> >               handler->list = &power_off_handler_list;
> >               break;
> >
> > +     case SYS_OFF_MODE_RESTART_PREPARE:
> > +             handler->list = &restart_prep_handler_list;
> > +             handler->blocking = true;
> > +             break;
> > +
> >       case SYS_OFF_MODE_RESTART:
> >               handler->list = &restart_handler_list;
> >               break;
>
> With the above comment addressed:
>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>
> --
> Best regards,
> Dmitry
>
