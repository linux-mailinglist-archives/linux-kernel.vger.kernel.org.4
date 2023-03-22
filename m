Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57B26C4EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCVPAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCVPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C6120A02
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 276C7B81D1B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130EDC4339E;
        Wed, 22 Mar 2023 15:00:04 +0000 (UTC)
Date:   Wed, 22 Mar 2023 11:00:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <20230322110002.120cf674@gandalf.local.home>
In-Reply-To: <ZBsWFOb9wDGSwRSW@MiWiFi-R3L-srv>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
        <ZBsSBr87al9ccG96@home.goodmis.org>
        <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
        <ZBsWFOb9wDGSwRSW@MiWiFi-R3L-srv>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 22:52:04 +0800
Baoquan He <bhe@redhat.com> wrote:

> When you resne patch, please fix Philipp's mail adress as
> 'Philipp Rudo <prudo@redhat.com>' if he should know this. He has joined
> Redhat.

But I thought redhat *was* IBM? ;-)

-- Steve
