Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAAF5F2F25
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJCKzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJCKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:55:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540A620F7D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 03:55:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso8271989wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Cozxca23ZwtW8YENAdgsI46I3MgpwQFagK3NzT6YNRc=;
        b=c4kwLQK2znlTPd6RySrwZdhPa24IhF2j9e9b9nq+QHS8N8m/g8uLAcbCZkG1TqOGXe
         VY44ZEkAugQEK+dxqncws3J7RfurvESSUzy2maExbjZFjsZslA8qT8lkzCQnuiGUwKLz
         H1LOu1MNp2Fn+OzVCBG0q9mSOHvDAW7UumXyhjyWWj/U31QmFJ8S7FcvlvDS0fHKEyw6
         LpaPmp9LyFOSNuSBieEbOGJ7QncwD3wLTlQfayWsob8QZ5+4LaCEVTg8CegXgyfRhf3w
         WR0hPdTU01ewpdPCPqO1iDmPHUqc0PRYDWNvX3H6xsb+oc2FfCJGZ2MHxeq+sy55jW7P
         E3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Cozxca23ZwtW8YENAdgsI46I3MgpwQFagK3NzT6YNRc=;
        b=LYyXtW45VfvWeGq0OMpnQKqjeTLS1gbTUOl8bkjtfTG+vvPXkmD7RQs9ajmzTJ+QRE
         1+TPFyFAI+EfW/YkbKEwq4XF+G2iWGC1QlsUniq5k2RZzN5Y4mL28jjnEbNAkTePgSF5
         mH1gSJFx73Xf2q5y4SKpdqUC/MBgMSN+RK8rRJI+HFlN+++sRaYd4ryvnGPD1ez3hKyw
         9yp1yqUspTY1Pr1VlovjOFPx5rutG65ijDuSVlve1eqlp89vPN3e9D1pCYyuLXWz1e0O
         fwIkrVaOwQ4w0vhVRz0aQoJyFmPvo+Ppk6SFXGrdLUup2nU3iz0pGnQyaQ0cIa3/2kAi
         jAdw==
X-Gm-Message-State: ACrzQf32nFgiNrH/RJW4bu3pUblz1obbqSzbusBQx9nyiAkB6TUXCSiF
        F/GS/+PCvnH67rnZCTEScyU=
X-Google-Smtp-Source: AMsMyM6/ElDwn9bMUfBg13WPdU5LwYpBHPNU3UrbAxqpDTiowh68eSqkMRpi5dRDNxOZo3Q3DsYGhQ==
X-Received: by 2002:a7b:ca46:0:b0:3b4:7ff2:1ca8 with SMTP id m6-20020a7bca46000000b003b47ff21ca8mr6473900wml.11.1664794504734;
        Mon, 03 Oct 2022 03:55:04 -0700 (PDT)
Received: from gmail.com (195-38-113-168.pool.digikabel.hu. [195.38.113.168])
        by smtp.gmail.com with ESMTPSA id r15-20020adfe68f000000b00228daaa84aesm9476433wrm.25.2022.10.03.03.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 03:55:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 3 Oct 2022 12:55:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [GIT PULL] perf fixes
Message-ID: <Yzq/hvPKqiCF+QkH@gmail.com>
References: <YzluYmeYjbxCr8wd@gmail.com>
 <CAHk-=wgJUKa9+7t7XdJskKjADRe6XuYc1ZvmTSfrxD+470AiSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgJUKa9+7t7XdJskKjADRe6XuYc1ZvmTSfrxD+470AiSw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Oct 2, 2022 at 3:56 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - Fix KVM guest PEBS register handling.
> 
> I wondered why my diffstat wasn't the same as yours, but it turns out
> it's because I got this one from the kvm tree earlier.

Oh - indeed, didn't notice that.

> It all merged fine, just surprising.

Yeah. These are the two commits:

  [perf/urgent]     f2aeea57504c ("perf/x86/core: Completely disable guest PEBS via guest's global_ctrl")
  [KVM tree]        87693645ae89 ("perf/x86/core: Completely disable guest PEBS via guest's global_ctrl")

Just to make sure I double checked that they are identical:

  thule:~/tip> git log -1 -p f2aeea57504c | grep -A 100 "^@@" | tail +2 | sha1sum 
  e758bebe3046ef6a51d19d7b5498e165dc8e37be  -

  thule:~/tip> git log -1 -p 87693645ae89 | grep -A 100 "^@@" | tail +2 | sha1sum 
  e758bebe3046ef6a51d19d7b5498e165dc8e37be  -

Paolo applied the fix a couple of hours after Peter, but we
never noticed the overlap & the perf/urgent base didn't have
Paolo's commit so I didn't notice when sending the tree.

Sorry about that!

Thanks,

	Ingo
