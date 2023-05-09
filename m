Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9C6FCFD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjEIUsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEIUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:48:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37C34499;
        Tue,  9 May 2023 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683665307; x=1715201307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+zV+uAS4q9V32crYnr8Zbb8CSTAhYVLj34nEaMyWUkM=;
  b=Apq6WWu/uZ19Au6lw86qGjCQqNHzW7Siz4s/ejGaIO1y3y8muxuBKgAx
   Rhm1y+2u7sDiqiWHtbTp/kme8smxwKZf+yiPF0QOJOVdml3qk2X2lAIjP
   9sduhV8NF/1kPtBHIi13/haAPsBafMm0KkvQ3rgHbuZ/o/r+OWB4X6gFb
   4aEslZhTb0rTHGprwtf/AUtE0nZDYP2AjBcPJIZxHx3M6jODvFHhbb6tL
   V/AR7Z6PssS9IBGBDsvNXYZGqkYZ8VLiFpyOyKnLzWWmHU1HgOEgjwRSr
   4MLLJHYc0GeAvV+sqriN5owe6cpltC5y84bNFDt9NBlncjXl9pF4karYL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="436368772"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="436368772"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 13:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="788658880"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="788658880"
Received: from dcourtn1-desk1.amr.corp.intel.com (HELO [10.212.182.218]) ([10.212.182.218])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 13:48:26 -0700
Message-ID: <055b41e9-b345-03fe-755c-cdcb08e4098b@intel.com>
Date:   Tue, 9 May 2023 13:48:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Cannot boot an i386-UEFI thinkpad lenovo tablet-2
Content-Language: en-US
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pjones@redhat.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZFnoXiZGGhuWDl2S@Red>
 <af88a590-e20a-0669-c0d8-e073cc6e109f@intel.com> <ZFqvCeNxKJDOYDaT@Red>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZFqvCeNxKJDOYDaT@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 13:37, Corentin Labbe wrote:
> Le Tue, May 09, 2023 at 07:01:02AM -0700, Dave Hansen a écrit :
>> On 5/8/23 23:29, Corentin Labbe wrote:
>>> The tablet has only one port, so I use a hub for keyboard and USB key.
>>> Immediatly after booting Linux, all hub port light goes to off.
>> If it's dying in the installer, can you boot it to a shell or rescue
>> media?  Are you getting any kernel messages on the screen before the
>> installer?
>>
> Sorry my sentence was not precise ("after booting linux"),
> 
> It die after pressing enter on grub menu.
> No kernel message, nothing new on screen.
> Only visible change are USB light off.
> 
> I have really no clue.

A lot of distros set the 'quiet' option to _keep_ the kernel from
spewing messages at boot.  Ubuntu sets "quiet splash", for instance.

Going into the grub menu and killing the 'quiet' and replacing it with
'debug' is a good place to start.  earlyprintk=vga can also help if
things are still blank at that point.  I thought we used to have an
earlyprintk=efi, but it seems to have vanished at some point.

But, you've got a bit of oddball hardware.  It's from the _far_ extreme
end of 32-bit-only hardware.  The fact that it had Windows on it isn't a
great sign.  There could be a BIOS bug that trips Linux up but Windows
is perfectly happy with.  There was definitely a sad period of time
where folks were not interested in fixing issues like that.
