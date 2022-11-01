Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44B615458
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKAVhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKAVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:37:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4731E725
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:37:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso176368pjc.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAGeZclIjBMFiBmV0n4LbZW8io+5YMRxyVOhuTAk5qw=;
        b=FYEKX7LpkD3IyhVOK2UB4R1S8Ui+o/o1MFilXFE+ITlFq/9x6MeK2KLm0E8IVhfOOu
         3cPOHKbTHaTg57/V5O7YzNhABL1msNpCOul4oX4Hx1BOLHcDF9vD5ZVyBqHxnGb4mGzw
         L47q0wTWQbxWh/JLB9fx45Y8WkUDFfWRHBmR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAGeZclIjBMFiBmV0n4LbZW8io+5YMRxyVOhuTAk5qw=;
        b=sYnnP8Sh1GZnHvUROY8dyOU+Z6yotYvLeRBMIEnQ2hZzFUbbqH3ZORPsQWSjFfag59
         MGZjUVNYBtD3WHhATqV9R1Ycd872unXEfU1z2O70wsbAm2b3M8bpCWQ01rIC4XG8vBCr
         ZMCgoKQ8AjlxpAKjItTmhrXGKzBL/OtHfo34wgsXN/dtot7YUM8v7KQMxhh6QFz4Ditk
         qGKh/LWJ1acb6rgKpu6mvi6WG9hr9H2DsoO9mPIYefA4VaJPosM1i+T6irgn0mYAEPu3
         4t/MRESTdX3LxeGPRkqdTwSpOXaN4MJFIU9wu29DF7dXKQVD4uc2dKkX6XdhAVBcooDf
         O+dQ==
X-Gm-Message-State: ACrzQf2bRzWKXxsyElM3IkEaFn5T1MUB5AbOSaRAlFM+vzK7Z9Mfys6p
        s2qq9RZqBt0wInFX4aFXpShgmw==
X-Google-Smtp-Source: AMsMyM5Fz7z4//NNU/2FQNhB3+uFr7/xzcvoPBqfaxkDh2S2pNYrRUQ5dD2oLYwynDTb/ap+OrDczA==
X-Received: by 2002:a17:903:2596:b0:186:a395:c4bd with SMTP id jb22-20020a170903259600b00186a395c4bdmr21887754plb.60.1667338638881;
        Tue, 01 Nov 2022 14:37:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k36-20020a635624000000b0046ae5cfc3d5sm6232753pgb.61.2022.11.01.14.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:37:18 -0700 (PDT)
Date:   Tue, 1 Nov 2022 14:37:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] igb: Proactively round up to kmalloc bucket size
Message-ID: <202211011433.A64BF17F46@keescook>
References: <20221018092340.never.556-kees@kernel.org>
 <20221018092526.4035344-2-keescook@chromium.org>
 <202210282013.82F28AE92@keescook>
 <DM5PR11MB1324802F3F2098CB3239CF36C1379@DM5PR11MB1324.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1324802F3F2098CB3239CF36C1379@DM5PR11MB1324.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 08:42:36PM +0000, Ruhl, Michael J wrote:
> Looking at the size usage (from elixir), I see:
> 
> --
> 	if (!q_vector) {
> 		q_vector = kzalloc(size, GFP_KERNEL);
> 	} else if (size > ksize(q_vector)) {
> 		kfree_rcu(q_vector, rcu);
> 		q_vector = kzalloc(size, GFP_KERNEL);
> 	} else {
> 		memset(q_vector, 0, size);
> 	}
> --
> 
> If the size is rounded up, will the (size > ksize()) check ever be true?
> 
> I.e. have you eliminated this check (and maybe getting rid of the need for first patch?)?

Hi!

It looked like igb_alloc_q_vector() was designed to be called multiple
times on the same q_vector (i.e. to grow its allocation size over time).
So for that case, yes, the "size > ksize(q_vector)" check is needed. If
it's only ever called once (which is hard for me to tell), then no. (And
if "no", why was the alloc/free case even there in the first place?)

-Kees

-- 
Kees Cook
