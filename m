Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1562D517
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiKQIfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQIfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:35:06 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EAB2EF72
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:35:05 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id c7so829568iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b2dzFEyPdMOGlhf7qsZ0lMgWK9FZa0x2Qd34XPaUbIs=;
        b=Qpdb9JD9Bnywd3J9/ToF1WZpRHTHjUW02OY0QXT12QLtwLfJC3xgWTWI2FcPC1sCA1
         L36Pfm/HvFiqM6UxwzpYNML9IXOfSLffRLD+L0Gc5M1BlxHdWbkkEvR9UNWPSJq52+Ja
         ImoxreGlmDFrV/2vNE6yqAwxX0flPiX3muuN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2dzFEyPdMOGlhf7qsZ0lMgWK9FZa0x2Qd34XPaUbIs=;
        b=v9KYoYiiZcQLmY+pxTijmbcPopTv2psgCeYhx95dtn85LCakHs5DmQSpV/zhqvviHW
         3wm04B9nX78rNNjnwnxL9un9y42FbAYOpbitrwXRVq+VpSe2iJS87EEhhs9BUq8mEwF4
         G7RN8iwaSyBJN/yGoHwBmWtGS4ZxL0ApgFAYK7zivNvcy53hF3TnMn5KbAvGVTGyGidF
         QitxWkVCC+LlqmBw0AZBlueCkTwi+Y/Wa+IRnCQp3YTSROLEM1nuzZ8pUE8BoXorAiCr
         JSqKOEjw84G/tdSKsPnBikcLsbjKp8dPsdNnoD5JtdiRE2+R6Dw6ovDq9lQ0ahR5zhHP
         ch+A==
X-Gm-Message-State: ANoB5pl46YqFd63r8fNPdRoScm1/a/v+Tt/EVFtWs1GDsTVcatV57Tih
        4+HxgUutqwcoQWWTMdFKa6/AL2c2SZsZLNd9JiN+GDvqJyA=
X-Google-Smtp-Source: AA0mqf4t3cgRcIK4SeVfudzWkfm0JhW2bG5OfPxbiLWLMFdIAYuELgM92FTFQFwXQ1pbQ7J/6CpnBrp1y5op7fOala0=
X-Received: by 2002:a05:6638:89:b0:363:9e67:d9d9 with SMTP id
 v9-20020a056638008900b003639e67d9d9mr625937jao.133.1668674104999; Thu, 17 Nov
 2022 00:35:04 -0800 (PST)
MIME-Version: 1.0
References: <CAKdx3izLgNJO+5ye4twe0+CFMcUBrFUa+-NdLN6VKKWQ76YiLA@mail.gmail.com>
In-Reply-To: <CAKdx3izLgNJO+5ye4twe0+CFMcUBrFUa+-NdLN6VKKWQ76YiLA@mail.gmail.com>
From:   Ozgur <ozgurk@ieee.org>
Date:   Thu, 17 Nov 2022 12:34:52 +0400
Message-ID: <CAADfD8yoBvzs77f6gVO8J9FSZxOkEnkqgAaSCjcfG2YhEZBvcw@mail.gmail.com>
Subject: Re: Can Not Send Netlink Messages with Unshare(CLONE_NEWNET)
To:     Hang An <anhang610@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:55 AM Hang An <anhang610@gmail.com> wrote:
>
> Hi,
> A process can not send netlink messages(errno is ECONNREFUSED) after
> running unshare(CLONE_NEWNET).
>
> Part of the call stack when process failed:
> netlink_sendmsg
> netlink_unicast
> netlink_getsockbyportid
> netlink_lookup(return NULL)
>
> The corresponding pseudocode is shown below:
> unshare(CLONE_NEWNET) ;
> res_socket = syscall(__NR_socket, 0x10ul, 3ul, 8);
> syscall(__NR_sendmsg, res_socket, msghdr, 0ul);
>
> I can't understand this situation. Is this a bug or special design?

Hello,

you have emailed a public linux-kernel list, so this list mainly focus
for development. maybe you should use bugzilla(1) to get answers to
your questions or you should ask question mentioned own kernel
subsystem (2).

1. https://bugzilla.kernel.org/
2. Network Subsystem | netdev@vger.kernel.org

Regards

>
> Thanks.
