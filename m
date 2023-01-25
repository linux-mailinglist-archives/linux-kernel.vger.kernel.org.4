Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D86867B701
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjAYQgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjAYQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:36:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13EB42E0FA;
        Wed, 25 Jan 2023 08:36:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83DD84B3;
        Wed, 25 Jan 2023 08:37:15 -0800 (PST)
Received: from bogus (unknown [10.57.77.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C30ED3F5A1;
        Wed, 25 Jan 2023 08:36:30 -0800 (PST)
Date:   Wed, 25 Jan 2023 16:36:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arch_topology: Build cacheinfo from primary CPU
Message-ID: <20230125163628.4yjwh3ja5vxnirun@bogus>
References: <20230104183033.755668-1-pierre.gondois@arm.com>
 <20230104183033.755668-7-pierre.gondois@arm.com>
 <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
 <20230124140420.4srnufcvamvff77v@bogus>
 <Y8/tl999NQwbPL/R@wendy>
 <20230124144839.2szjjv256j3pdaif@bogus>
 <20230124145541.2xwtr7ro2bjnsjd7@bogus>
 <20230125145423.pid3hsstswzuez73@bogus>
 <CAMuHMdWZ+_kdMp+0VfYAJZRHBWiyobQQJwEM_kHN6yeVVGxSvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWZ+_kdMp+0VfYAJZRHBWiyobQQJwEM_kHN6yeVVGxSvg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 04:28:04PM +0100, Geert Uytterhoeven wrote:
> Hi Sudeep,
>
> On Wed, Jan 25, 2023 at 3:54 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Tue, Jan 24, 2023 at 02:55:41PM +0000, Sudeep Holla wrote:
> > > Geert, can you please try with the patch Conor pointed out and see if
> > > that helps to fix the allocation failures[1]
> > >
> >
> > Sorry for the nag, but did you get the chance to test -next with [1]
> > and see if it fixes the cacheinfo memory failure you were observing ?
>
> > [1] https://lore.kernel.org/all/20230103035316.3841303-1-leyfoon.tan@starfivetech.com/
>
> After applying that patch, the issue is gone.
> Thanks, sending my Tb!
>

Thanks for testing and sorry for wrong information in my PR. I had mixed
up things and assumed it was tested. I usually leave it in -next for a week
before sending PR but rushed things once I was back from the holidays, won't
repeat hopefully 🤞.

--
Regards,
Sudeep
