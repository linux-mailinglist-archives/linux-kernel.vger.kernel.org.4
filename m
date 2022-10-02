Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB35F23EF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJBPtd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Oct 2022 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJBPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 11:49:31 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9845426ACB;
        Sun,  2 Oct 2022 08:49:30 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 7CF16140A73;
        Sun,  2 Oct 2022 15:49:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id A6DB017;
        Sun,  2 Oct 2022 15:49:18 +0000 (UTC)
Message-ID: <f7f6a67c5ee662f24885579ba09b281a5d597b0a.camel@perches.com>
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate
 supporters should be mailed
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Akira Yokosawa <akiyks@gmail.com>, corbet@lwn.net,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@leemhuis.info
Date:   Sun, 02 Oct 2022 08:49:24 -0700
In-Reply-To: <dabbb4aa-d5e1-10d5-082c-1386f3314fc8@linaro.org>
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
         <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
         <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org>
         <Yzen4X1Na0MKXHs9@mit.edu>
         <70759d05-2646-57e5-0b87-3a196488f622@linaro.org>
         <dabbb4aa-d5e1-10d5-082c-1386f3314fc8@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A6DB017
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 1o5h1wfjkqypcadoyi7mgbgfsujaedts
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+1XEvdPSa+SxGXSoTRML7cqCBJBbeEkAg=
X-HE-Tag: 1664725758-931206
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-10-02 at 09:58 +0200, Krzysztof Kozlowski wrote:
> The easiest to achieve it is to run with --no-git-fallback and CC entire
> output. However it does not mean submitter must run with
> --no-git-fallback. It is only for this generic rule - CC entire output
> of get_maintainers.pl.
> 
> If you add such rule "CC entire output of get_maintainers.pl" and do not
> mention no-git-fallback, some folks will think they need to CC all these
> people who made one commit to your file...

false.

git-fallback is _not_ used when there is a listed maintainer for a
specific file.

If there is a use of git-fallback, it's because there is _no_
specified maintainer for a specific file.

   --git-fallback => use git when no exact MAINTAINERS pattern (default: 1)

i.e.: It's not "your file" if you don't maintain it.
