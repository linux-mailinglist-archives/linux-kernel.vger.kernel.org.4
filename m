Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2A6C09B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCTEen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjCTEeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:34:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4601D21280;
        Sun, 19 Mar 2023 21:33:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c18so11171978ple.11;
        Sun, 19 Mar 2023 21:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679286829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhjZz/NfFkzkOrH5dOtayCqjpoAXNIQg89V9pLQQEy8=;
        b=TMWS8S8Qnf1HXHnwnApp5iSmwBQVWTqJG0asMirPpPiwIfac8cNIHseIC4/mOkImYe
         YBMm3NXvYEiv5GDJSAvtVNT86eI1pQzAMx9ocrdPKXNUu9pfaW9+huZ+WWNHrwTWHJeR
         mzMcAeC2HucHzTu2r3mAAXP41vHNb8aLpMASMp7f276EN+m4GX/IUyJo0G7fSIEAzjCR
         ssTOggeLhhB4c4wo2t7e4b26JgHa6/VyIUghcfmoUMHveFNAZhu2aNtjFqS2OCFXBRXN
         M2RiIXE4IHF5eAkjc3F0xPjAL4JwGIJ/JPSqja0ZkFiEgff35y9H+JYB7DL8qsmFIYxL
         RywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679286829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhjZz/NfFkzkOrH5dOtayCqjpoAXNIQg89V9pLQQEy8=;
        b=NTFQtYyVJqIcgZdZjDMCrEeCB0cXfKW8bMHMZWw6I70Xi4XuDhiZWozRjOR+UIlWpk
         gtJHQDcCbitm8NEpVD3SC0gv/wMemVZzbGmFd8ZIWE0v/mh115eYJTsqKR3D839Y1RJO
         i6F0Fpu98PXGbrIDQzw0vudw8BTefeo8RV5xmXrTSrY5QHyJqu3U9vds0WP9609/Vz83
         2L1HsbvjaJ4ydWqOkGvZTwAmHuINqnDEtxQcuPPxwOeCsXC9qsYIeldldfl3zdPf3yki
         MSd9ouEOd5t0VEu2OmKmHE3nK631gUP5h79Rgn/sur2uqt9XNYeFV2CwasoaEpLz3Wds
         JDxA==
X-Gm-Message-State: AO0yUKW2a8siLEpe7K49ShVBPGz2Da5Mns0476/vWKIVn472gW/i7hho
        whaoOPZ85oNa2JjfizvAweI=
X-Google-Smtp-Source: AK7set+vfET8VPU5zFcyVHGbKQoxtEOeVkC6MHndPhV8fMy+OUstN0TvKRpWR1v/I7ORW0I7UZcM0w==
X-Received: by 2002:a17:90b:1d83:b0:233:cd29:f168 with SMTP id pf3-20020a17090b1d8300b00233cd29f168mr18558552pjb.24.1679286829513;
        Sun, 19 Mar 2023 21:33:49 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:687c:5175:b0b1:a145])
        by smtp.gmail.com with ESMTPSA id jm2-20020a17090304c200b001a04d27ee92sm415690plb.241.2023.03.19.21.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 21:33:48 -0700 (PDT)
Date:   Sun, 19 Mar 2023 21:33:45 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Matthias Benkmann <matthias.benkmann@gmail.com>,
        linux-input@vger.kernel.org, Nate Yocom <nate@yocom.org>,
        hadess@hadess.net, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH v3] Fix incorrectly applied patch for MAP_PROFILE_BUTTON
Message-ID: <ZBfiKc2IHtonxy7o@google.com>
References: <CAK4gqCCk7ipRbZ=LM8Nsj+nE2S6v6QN39ziYSr3d2NmVMHULYg@mail.gmail.com>
 <20230318162106.0aef4ba5@ninja>
 <20230318180047.3pzcep5roaon3nph@intel.intel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318180047.3pzcep5roaon3nph@intel.intel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 07:00:47PM +0100, Andi Shyti wrote:
> On Sat, Mar 18, 2023 at 04:21:06PM +0100, Matthias Benkmann wrote:
> > When the linked patch was applied,
> 
> Please refer to the patch as "commit fff1011a26d6 ("Input: xpad -
> add X-Box Adaptive Profile button")" and not as "linked patch".
> 
> > one hunk ended up in the wrong function. This patch moves it to where
> > it probably belongs.
> 
> probably? We need to be sure here :)
> 
> Besides, please, use the imperative form, not "this patch moves"
> but "move what where", please be more specific.

Reworded and applied, thank you.

-- 
Dmitry
