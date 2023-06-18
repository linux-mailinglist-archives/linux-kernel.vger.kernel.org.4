Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61A7346B3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjFROyy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Jun 2023 10:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFROyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 10:54:52 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26C3C5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 07:54:51 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 85B8EAF9F7;
        Sun, 18 Jun 2023 14:54:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id CB73D1B;
        Sun, 18 Jun 2023 14:54:47 +0000 (UTC)
Message-ID: <4fefbd7697c593b25ecc981668cc7bae1a1212d9.camel@perches.com>
Subject: Re: [PATCH] workqueue: format pr_warn exceeds line length in
 wq_numa_init
From:   Joe Perches <joe@perches.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>, tj@kernel.org,
        linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net
Cc:     tiozhang@didiglobal.com
Date:   Sun, 18 Jun 2023 07:54:45 -0700
In-Reply-To: <CAJhGHyDTQFCA1KJGZjnb9yV-es5f_rz2mvoXm-RuiKuW2fXvcQ@mail.gmail.com>
References: <20230616070041.GA32700@didi-ThinkCentre-M930t-N000>
         <CAJhGHyDTQFCA1KJGZjnb9yV-es5f_rz2mvoXm-RuiKuW2fXvcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: CB73D1B
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: iizqkfy7wtwoc7o3cimfey14cgead7n6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+cRK7rSkNANajA3jaD43ZwaKMPzf3murA=
X-HE-Tag: 1687100087-147404
X-HE-Meta: U2FsdGVkX189TGuvXrBqh/jRC/4R6aI59sqYT4nUnZcSQT8h1a1kRPBliILswJE38ETDZ5VGqub2XiuJu56YxvZ67qYdi9ikWP2RYu7zizeNPQU5Hcz6StAEpL8khxzQcuaD9MdreEkQNSRHq5iHbMc7R0IE04VzIVd0VCZqpXIxdg3rqtVxlGYNdQVtHADUDA31fq9C2t+gdg793ks6crq40RaPFjiuGmQAWQEU4G6LHArBe0oCTbsi7CRs9zRnKSVZj5AndKPyVHG+XdAkxuBAWkM3CYHnpjLsOTq9oo2pHgUSIkj+zOkQVMzqwM5ujuyhErWn6yd+CAMbnoPB79URBX09DuWGc88iwlezON9EnGyFdtF+QHAQLU/TELoC
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-06-18 at 09:19 +0800, Lai Jiangshan wrote:
> On Fri, Jun 16, 2023 at 3:00 PM tiozhang <tiozhang@didiglobal.com> wrote:
> > 
> > Format this long line which would potentially let checkpatch complain
> > "WARNING: line length of 103 exceeds 100 columns".
[]
> This patch hurts the readability actually. A few extra characters exceeding
> is Okay for me.
[]
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
[]
> > @@ -5959,7 +5959,8 @@ static void __init wq_numa_init(void)
> > 
> >         for_each_possible_cpu(cpu) {
> >                 if (WARN_ON(cpu_to_node(cpu) == NUMA_NO_NODE)) {
> > -                       pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
> > +                       pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n",
> > +                               cpu);

What _might_ work reasonably well is to add

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

before any include and remove "workqueue: " from
all pr_<foo> uses.

