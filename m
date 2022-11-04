Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADED619A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiKDOha convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Nov 2022 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKDOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:36:37 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914FE31FA0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:33:45 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id B1E30A1409;
        Fri,  4 Nov 2022 14:33:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 4B6D220028;
        Fri,  4 Nov 2022 14:33:40 +0000 (UTC)
Message-ID: <a8b903f83433c710fff6f80b5bd5353b9be663a9.camel@perches.com>
Subject: Re: [PATCH -next v2] checkpatch: Add check for array allocator
 family argument order
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Liao Chang <liaochang1@huawei.com>
Cc:     apw@canonical.com, dwaipayanray1@gmail.com,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        pbonzini@redhat.com
Date:   Fri, 04 Nov 2022 07:33:39 -0700
In-Reply-To: <CAKXUXMxi_aqnvCmYjakQzoYvYqqwrvMnFt-czLV1iUnO0TnScg@mail.gmail.com>
References: <20221104070523.60296-1-liaochang1@huawei.com>
         <CAKXUXMxi_aqnvCmYjakQzoYvYqqwrvMnFt-czLV1iUnO0TnScg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4B6D220028
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 4sjyohrgqpg944iu7h8hd45b31x5o5r7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19wD3RqL7rcRrcmMu0rbTYsZy3DyVjpZy4=
X-HE-Tag: 1667572420-735852
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-04 at 09:35 +0100, Lukas Bulwahn wrote:
> On Fri, Nov 4, 2022 at 8:08 AM Liao Chang <liaochang1@huawei.com> wrote:
> > 
> > These array allocator family are sometimes misused with the first and
> > second arguments switchted.
> 
> Just a nit:
> 
> s/switchted/switched/
> 
> But probably you actually mean "swapped". I think there is a slight
> difference between the two words, "switched" and "swapped". And here
> the arguments are swapped. Note: I am also not a native speaker.
> 
> For the implementation change:
> 
> Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> How many new findings are now identified with this extended check on
> linux-next? Could you run checkpatch on all files of linux-next and
> share the new findings? Then we can do a quick scan if some instances
> should be immediately fixed or some janitor should follow through with
> such a task.

There are ~25.
It's fairly trivial Lukas and only cosmetic.

https://lore.kernel.org/lkml/d92ada3062bc1c3a7557bfa0499fc4a8cee3aa10.camel@perches.com/

