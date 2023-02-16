Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4769898B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBPA4R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Feb 2023 19:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBPA4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:56:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F52A153;
        Wed, 15 Feb 2023 16:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 645AAB8245D;
        Thu, 16 Feb 2023 00:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A658C433EF;
        Thu, 16 Feb 2023 00:56:11 +0000 (UTC)
Date:   Wed, 15 Feb 2023 19:56:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: Re: [PATCH v2 5/7] platform/x86/intel/ifs: Trace support for array
 test
Message-ID: <20230215195609.288a5709@rorschach.local.home>
In-Reply-To: <20230214234426.344960-6-jithu.joseph@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
        <20230214234426.344960-1-jithu.joseph@intel.com>
        <20230214234426.344960-6-jithu.joseph@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 15:44:24 -0800
Jithu Joseph <jithu.joseph@intel.com> wrote:

> Enable tracing support in array test flow.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

From the tracing POV:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  include/trace/events/intel_ifs.h         | 25 ++++++++++++++++++++++++
>  drivers/platform/x86/intel/ifs/runtest.c |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
> index d7353024016c..d15037943b80 100644
> --- a/include/trace/events/intel_ifs.h
