Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A56C5B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCWASd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWASb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ADB119
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679530663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qSegs/F/HLoYtMQB109vZlwrTGVYOoKZXOG+DxwqFiw=;
        b=GkdGbgfbzore2Sx812nQLiX8rZUwJFDuK4/qLgL7zW7UqIc4gLKf3MZtK0mAEE7PYvlkov
        kaw1rrIpPEZxqlU3SJYVdANgEYjOpGBGtA7azJ1VgI2g8BY/W7hMTfC91jT4e4a2EWOCjG
        Ixx9tSDMYnlAWHp+fNPAR0iUyWX/49M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-efND3qEnOFeiV3szBBL7Ww-1; Wed, 22 Mar 2023 20:17:39 -0400
X-MC-Unique: efND3qEnOFeiV3szBBL7Ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 813D9101A531;
        Thu, 23 Mar 2023 00:17:39 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B84951731B;
        Thu, 23 Mar 2023 00:17:38 +0000 (UTC)
Date:   Thu, 23 Mar 2023 08:17:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <ZBuan2/9CVPffy9a@MiWiFi-R3L-srv>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
 <ZBsSBr87al9ccG96@home.goodmis.org>
 <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
 <ZBsWFOb9wDGSwRSW@MiWiFi-R3L-srv>
 <20230322110002.120cf674@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322110002.120cf674@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/23 at 11:00am, Steven Rostedt wrote:
> On Wed, 22 Mar 2023 22:52:04 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > When you resne patch, please fix Philipp's mail adress as
> > 'Philipp Rudo <prudo@redhat.com>' if he should know this. He has joined
> > Redhat.
> 
> But I thought redhat *was* IBM? ;-)

That's interesting questioin, maybe yes on capital operation, but no
from company operation and management, in an engineer's eyes.

