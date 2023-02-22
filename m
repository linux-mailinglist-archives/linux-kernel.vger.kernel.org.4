Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C6169FEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjBVWrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjBVWrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:47:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A110828D13;
        Wed, 22 Feb 2023 14:47:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2EBD615B5;
        Wed, 22 Feb 2023 22:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0432EC433EF;
        Wed, 22 Feb 2023 22:36:55 +0000 (UTC)
Date:   Wed, 22 Feb 2023 17:36:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Joseph, Jithu" <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST
 test
Message-ID: <20230222173654.275a2c78@gandalf.local.home>
In-Reply-To: <8fb5ebbf-d468-169d-5603-b267e7b42516@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
        <20230214234426.344960-1-jithu.joseph@intel.com>
        <20230214234426.344960-5-jithu.joseph@intel.com>
        <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
        <d9d18954-8434-4c85-88b8-8e1d99cd6a4b@intel.com>
        <dd501d6a-e7e9-be82-24fb-33b18fb6192b@intel.com>
        <b67d2125-4075-4eac-4cad-8e315b866144@intel.com>
        <5d57f42a-1bfc-5e6a-bb49-556ecb7402af@intel.com>
        <9c55a34b-c17e-2a62-9989-902ce940dde5@intel.com>
        <42ac85ea-0ffe-55fc-57c2-6f4555e8dc5b@intel.com>
        <8fb5ebbf-d468-169d-5603-b267e7b42516@intel.com>
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

On Wed, 22 Feb 2023 14:28:55 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/22/23 14:07, Joseph, Jithu wrote:
> > Since the trace has to be explicitly enabled (I thought it is okay to
> > add a more convenient custom one only to be enabled for detailed
> > analysis when required).  
> 
> 	man perf-script

Or do it in C with tracefs :-)

  https://www.trace-cmd.org/Documentation/libtracefs/

-- Steve


> 
> You should be able to write one to do exactly what you need in about 10
> minutes.  No new tracepoints, no new kernel code to maintain.  Knock
> yourself out with whatever conveniences you want.  Just do it in userspace.
> 
> I still think this patch should go away.

