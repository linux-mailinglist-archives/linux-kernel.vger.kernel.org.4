Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC763B603
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiK1Xh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbiK1XhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:37:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6049432B91;
        Mon, 28 Nov 2022 15:37:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F02D761451;
        Mon, 28 Nov 2022 23:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D87C433D7;
        Mon, 28 Nov 2022 23:37:20 +0000 (UTC)
Date:   Mon, 28 Nov 2022 18:37:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
Message-ID: <20221128183718.46c08bb5@gandalf.local.home>
In-Reply-To: <20221128172347.629a75c2@rotkaeppchen>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
        <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
        <20221117160650.16e06b37@rotkaeppchen>
        <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
        <20221121150948.6f7c1f1f@rotkaeppchen>
        <CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
        <20221124124000.5af23cad@rotkaeppchen>
        <CANiDSCvO+6TrM900Z_Jr4QL=c1uHS21deto7cU9W4mr7KimhJQ@mail.gmail.com>
        <20221124160115.23ae7928@rotkaeppchen>
        <CANiDSCvJqPogBXWUvQq6ZZaX_bonLBLhJXFyNQbULb0WnJw5UQ@mail.gmail.com>
        <20221128172347.629a75c2@rotkaeppchen>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 17:28:55 +0100
Philipp Rudo <prudo@redhat.com> wrote:

> To be honest I don't think we make a progress here at the moment. I
> would like to hear from others what they think about this.

Not sure if you missed my reply.

  https://lore.kernel.org/all/20221128114200.72b3e2fe@gandalf.local.home/

-- Steve
