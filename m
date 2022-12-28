Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591196571E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiL1BzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiL1BzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:55:17 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Dec 2022 17:55:16 PST
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A710B3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:55:16 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1pALa7-0008of-Pk
        for linux-kernel@vger.kernel.org; Wed, 28 Dec 2022 02:50:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Tavis Ormandy <taviso@gmail.com>
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Followup-To: gmane.comp.security.oss.general
Date:   Wed, 28 Dec 2022 01:50:03 -0000 (UTC)
Message-ID: <tog7cb$105a$1@ciao.gmane.io>
References: <Y6SJDbKBk471KE4k@p183> <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
User-Agent: slrn/pre1.0.4-5 (Linux)
Cc:     oss-security@lists.openwall.com, linux-man@vger.kernel.org
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-28, Lyndon Nerenberg (VE7TFX/VE6BBM) wrote:
> Dominique Martinet writes:
>
>> But, really, I just don't see how this can practically be said to be parsable...
>
> In its current form it never will be.  The solution is to place
> this variable-length field last.  Then you can "cut -d ' ' -f 51-"
> to get the command+args part (assuming I counted all those fields
> correctly ...)
>
> Of course, this breaks backwards compatability.
>

I think that cut command doesn't handle newlines, you probably need cut
-z, which looks a bit hacky to me. There already is 'ps -q $$ -o comm=',
of course, and that works fine - as well as libprocps.

I don't know, I think just adding the strrchr note seems acceptable.

Tavis.


-- 
 _o)            $ lynx lock.cmpxchg8b.com
 /\\  _o)  _o)  $ finger taviso@sdf.org
_\_V _( ) _( )  @taviso

