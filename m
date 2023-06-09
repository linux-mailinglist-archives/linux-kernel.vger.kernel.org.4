Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF9729B86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbjFINXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbjFINXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:23:20 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309EB30F7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:23:17 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qd1wz1ZfdzMq1T5;
        Fri,  9 Jun 2023 13:23:15 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qd1wt0pvCzMqMwh;
        Fri,  9 Jun 2023 15:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686316995;
        bh=DBO16dw9EEaGwmi4IcbIok68ZhMJPTSXuTDZrRpaG/Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rKYrlMVgnaoAwa9PzFD+laAMw51WsT5Bvur3Ix78cy9LsJyGpYmLxbZUNDUGFbVxA
         tNCqSleMpnmDU8bheeOOyOzz1KzWQvna/vCACQl1O8/cf8NRY6FBLaeONR00YE9Wy8
         xNFgXs7fZvRK79cRS9sN8NCeh8PFzh19ygzt9sPM=
Message-ID: <8f27ad5f-9a9c-3db0-a934-88e1810974f3@digikod.net>
Date:   Fri, 9 Jun 2023 15:23:08 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
        ojeda@kernel.org, danny@kdrag0n.dev
Cc:     masahiroy@kernel.org, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org,
        mailhol.vincent@wanadoo.fr
References: <20230601075333.14021-1-ihuguet@redhat.com>
 <87sfb1oz13.fsf@meer.lwn.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <87sfb1oz13.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/06/2023 09:50, Jonathan Corbet wrote:
> Íñigo Huguet <ihuguet@redhat.com> writes:
> 
>> EditorConfig is a specification to define the most basic code formatting
>> stuff, and it's supported by many editors and IDEs, either directly or
>> via plugins, including VSCode/VSCodium, Vim, emacs and more.
>>
>> It allows to define formatting style related to indentation, charset,
>> end of lines and trailing whitespaces. It also allows to apply different
>> formats for different files based on wildcards, so for example it is
>> possible to apply different configs to *.{c,h}, *.py and *.rs.
>>
>> In linux project, defining a .editorconfig might help to those people
>> that work on different projects with different indentation styles, so
>> they cannot define a global style. Now they will directly see the
>> correct indentation on every fresh clone of the project.
>>
>> See https://editorconfig.org
>>
>> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
>> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
>> Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
> 
> So I must confess to still being really nervous about installing a file
> that will silently reconfigure the editors of everybody working on the
> kernel source; I wish there were a straightforward way to do this as an
> opt-in thing.  We're talking about creating a flag-day behavioral change
> for, potentially, thousands of kernel developers.  Something tells me
> that we might just hear from a few of them.
> 
> I wonder if we should, instead, ship a file like this as something like
> Documentation/process/editorconfig, then provide a "make editorconfig"
> command that installs it in the top-level directory for those who want
> it?
> 
> Or perhaps I'm worrying too much?

This is a legitimate concern. :)

A safe approach would be to rename the ".editorconfig" file to something 
like ".editorconfig.default" and create ".editorconfig" symlinks in all 
(parent) directories where enforcing this rules don't change anything 
because the children files are already correctly formatted. Again, a 
script (provided in another patch) to check and potentially update such 
links would be useful.
