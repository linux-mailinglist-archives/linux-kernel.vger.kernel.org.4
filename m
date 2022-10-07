Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58A5F74C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJGHiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJGHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:38:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF5BEFBB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:38:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r17so9493729eja.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ku0WBdsuMJGZ8wwI4SyomnhiRhTorORkpnPBO0up1yE=;
        b=Jay2kDsdMF/g4Udi2DLXcFb160zjAC+Il3BuXygkD/KUa9inF37wDdq8KHv8gSWp1w
         1uq3dvlUTTmzQDG+IadTuaqLwvI9+Cr2d+kUa/0llsY9t9oyI0R3iFCeYsq1eA2+DyO6
         k15czwk1jOM6XckTTBX5jrSdGgm/qXbUs+ZDZLGDTNj/tO2GWxeQG+2b6EwmDemp6nye
         PGdhsiI1f6Aaz6JW2orY10xcNuBRnslhLJZb4t+hoysAhcJkyILR7Oe+Kn9PsDeWZyYt
         C0HsqsnIgngTSE0TFSOvGrxG71U3OElS4URg4kbvdWqlfWESCclFVGTLfPVbLo7MsjXK
         dtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ku0WBdsuMJGZ8wwI4SyomnhiRhTorORkpnPBO0up1yE=;
        b=LJp2+AwmMfHRFA+Cpvv1vKqSmgbNY/pOwonLGev+3up39tjYfG2Fie0Y7ZfqG0g6u/
         MMMMTP6ScUF1c80bpN7llVDTB5LOKSExuggmo767q0jZ6WfJm8ISvROTYdRJfWqO3RNv
         jSzAn2rnOy0LgagiGJQ6E3sGM0CV9l4DJI+w7r/Df4Pye4WzLpsg6cBcgwdICPaBo4oe
         uUX9QQ9Q29ALgmgDLiku1ghFTNOsiQes1voNG0OdUi9lunR1zIVCdwBKVJuRg0BY3hrP
         Ly7SaRKCidv11ZuL5PjV0VTgMb9SMaOIPE4EB5Xp+nVwS5W00inDQC7GOmnKLWH1nLu9
         NWPA==
X-Gm-Message-State: ACrzQf2F4ngRL44Cq3e8ngOXYhTFar3CBMRbVS4x5IcxomgFum5RHm6W
        vt7F70WIR67mJCKSCgg9mDLcaPyCBCNJjt0IFotcvrGJdWJLjQ==
X-Google-Smtp-Source: AMsMyM7ZGR1jzbxdNbPC02pdYz7WmIREumAZNtbfzGT/YJtqv7JoDfUrE95PbWwygMwEe2Ji0VjVZFyG42qEeOc4cu0=
X-Received: by 2002:a17:907:60c7:b0:78c:b9e8:89b8 with SMTP id
 hv7-20020a17090760c700b0078cb9e889b8mr2984367ejc.439.1665128290828; Fri, 07
 Oct 2022 00:38:10 -0700 (PDT)
MIME-Version: 1.0
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Fri, 7 Oct 2022 13:07:54 +0530
Message-ID: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
Subject: Reg the next LTS kernel (6.1?)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!
I'm working on the 2nd edition of the Linux Kernel Programming book
(https://www.amazon.com/gp/product/B07RW915K4/ref=dbs_a_def_rwt_bibl_vppi_i0)
and request your help...

I'd like to base the book upon as recent a kernel version as is
feasible, of course, with the caveat that it's a long-term (LTS) one
that will be around for a while. Currently, the 5.10 LTS kernel's EOL
date - Dec 2026 - makes it an ideal candidate.

However, if possible, I'd (also) like to use a 6.x kernel; so, my
question comes down to this: will a 6.1 kernel release occur soon (I
heard it should be around Dec this year)? Will it be an LTS kernel
(again, should be I guess), and, if so, very important for me, what's
the likely EOL date?

Much appreciate your time, TIA.
T&R,
Kaiwan.
