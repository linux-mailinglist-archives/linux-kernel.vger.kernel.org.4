Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B200628B05
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiKNVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiKNVGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:06:23 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C9265;
        Mon, 14 Nov 2022 13:06:22 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id v7so8385657wmn.0;
        Mon, 14 Nov 2022 13:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdv5tthp2cYx/JZK69g8/6+Z4be/rjjn+QYGbW7ClUA=;
        b=xdfXXRSwSj1cM2SVHnLhtG++1PA7oaiky6RP7H4nlq+OqjWkJXtnBvVca9iLOF6a7Y
         zSQWBjWm2Sqlz87ySCTYEirIDSmmKLft281kbV53Md3gxpmWA1bpmgWdPnV1/AEMolUm
         fu1ucd5Ufhw0XLYRSavj9u/HlP8B+AQbnRwGtC+g5cJBS28MoPca+MtKlPOoW9t4wwuZ
         tdRFuSzKhdnCPbF+4Xm0bo9RUql9+UNe+H6a4QIzDW2ut9ceOHz6FOZJmI42PfV55RaH
         UV6C4YkKQ0myk46BB0Vok/rmYdfQgQOcPFd1AD/qmzw0QJXu+Tc3xgVCY0iT66+fWtEd
         6jyQ==
X-Gm-Message-State: ANoB5pkZPAxcRks9LdanhCcaWztOAaBh/OCjq00J5sKTQApvUeNkQOyq
        QkVx3m1cfJFHy+xUOSsVYR5z+kIEuqs=
X-Google-Smtp-Source: AA0mqf560ZbxAGo3lAxHlrciszmft+dMMi36J1EaoBxNd3F8x93JXfD4Wx1I2fSc80GmyF6PnmFwNA==
X-Received: by 2002:a05:600c:3544:b0:3cf:b067:416c with SMTP id i4-20020a05600c354400b003cfb067416cmr9441924wmq.134.1668459964440;
        Mon, 14 Nov 2022 13:06:04 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003c6d21a19a0sm15255965wms.29.2022.11.14.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:06:04 -0800 (PST)
Date:   Mon, 14 Nov 2022 21:06:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 25/28] rust: add `build_error` crate
Message-ID: <Y3KtuvAEJoavLQXr@liuwe-devbox-debian-v2>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-26-ojeda@kernel.org>
 <Y3JQ8qsaV/DN3OJ7@liuwe-devbox-debian-v2>
 <CANiq72ktW2=JCi3YzyrAd=_RioaWGZSyDusMU2f92_aL3tgvUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72ktW2=JCi3YzyrAd=_RioaWGZSyDusMU2f92_aL3tgvUA@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 07:22:02PM +0100, Miguel Ojeda wrote:
> On Mon, Nov 14, 2022 at 3:30 PM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > a const function `build_error`
> >
> > Without this I read it as a "normal non-const function".
> 
> Sounds good to me, especially given the sentence that goes after that.
> 
> (I think "function" does not imply one or the other in principle. To
> me, `const` ones are normal too, in the sense that they can be used as
> any other function.)
> 
> > I can work out what the code does, but I also happen to know what Rust's
> > const means and its behaviour in non-const context. Other kernel
> > developers may not. Even so the description is a bit difficult for me to
> > parse.
> >
> > Maybe a few sentences about const and its behaviours can help?
> 
> Not sure if we should explain language details in the documentation of
> particular functions. But I agree this case is a bit special.
> 
> What about linking the Rust reference/book/... (so that those terms
> are clickable when rendered)?

I think this works too.

> 
> Thanks a lot for the reviews, Wei!
> 

You're welcome.

Thanks,
Wei.

> Cheers,
> Miguel
