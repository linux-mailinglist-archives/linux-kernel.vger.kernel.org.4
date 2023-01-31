Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6DA683238
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjAaQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjAaQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:07:34 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45CC142;
        Tue, 31 Jan 2023 08:07:33 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-15fe106c7c7so19925679fac.8;
        Tue, 31 Jan 2023 08:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlJoguK982+kO7T2uOCdKMNuyyt02oHs2sPS+iRFOYQ=;
        b=KGg9JB0195ErXV4ykn/ODGZms/7r0VvR90JlsYvs7ldmTzB1gUDsgu8n4BXkCmWOZ0
         Y90cp4liWbWmIJ8zeCyWO4/GQjMJGmZm1FggGm88PztYLq8+aNyJqw2Zns1mgXUL2PQw
         Oo+sILBJzh2SUzp+1HHkpJ6RcG6Uew05+1shSTJNPvEB8jxfqs8G/Nj8aJdnZtPdVcHN
         aVg5eu3zrrW+TD60gYIXjeu6pG574Qju+6fjt2/Km1O3icA5b62sHXu+JdSlWyZNqJVs
         5SYzbjKXoBlCFnU4bpwiVtgp3UkaIDWAHBeq2Ho91pIbd3a6kJB2rLbPdPg/0lWQflUX
         hV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlJoguK982+kO7T2uOCdKMNuyyt02oHs2sPS+iRFOYQ=;
        b=DBTHeMhGQjTmZsM9OpBzD8VgDabRVqhssSiS42/iIGTIpqK9Ki+yd9LZwW0gDUNuDX
         0OhKNCOpwpTBpKjjWjKexLRQNdEF9sNgpWTdJgTaS/J17ZDUlAq+MzlPOACnmy9BXs/Y
         2HvNYy4tfpfQHYpsvFq+9EN8HBDooiV2CrxA8eWKGHDGHUaG4KqL6xvpgzsW01F2mJkX
         VfHOku2REiZfNnOv3W8vC0Yi1mkYN9uN4ZDwBMqy2gTmy1bQaBJn5MtFBZCkgF6hykg2
         RWK3GpfLiXk44YbLvX+j498oWYHsOIv/UdCEs0TZtWoheJw+x8rB68yh7F/w7h52mwPe
         AfTg==
X-Gm-Message-State: AO0yUKW/76Pwx58S5jxP3v0MeYtCunj/sa8lG2r6u5X4WlnDarCPo//O
        lrdVEjktd1xtcMm54mmCJUI=
X-Google-Smtp-Source: AK7set/di3NWLbvj+4d+uPUsXRKj/KHCpdXmXsSRemOVZOVBfemqVwszIfyP7JZWWtuSuUcD4C6BFQ==
X-Received: by 2002:a05:6870:8927:b0:163:c8d4:3983 with SMTP id i39-20020a056870892700b00163c8d43983mr4447196oao.29.1675181252857;
        Tue, 31 Jan 2023 08:07:32 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id g5-20020a05687054c500b0014866eb34cesm6642803oan.48.2023.01.31.08.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 08:07:32 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
Subject: Re: [PATCH] rust: add this_module macro
Date:   Tue, 31 Jan 2023 13:07:28 -0300
Message-Id: <20230131160728.400481-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <Y9kwpw18SVx9GZC4@kroah.com>
References: <Y9kwpw18SVx9GZC4@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 04:15:51PM +0100, Greg KH wrote:=0D
>On Tue, Jan 31, 2023 at 12:07:45PM -0300, Martin Rodriguez Reboredo wrote:=
=0D
>> On Tue, Jan 31, 2023 at 02:42:08PM +0100, Greg KH wrote:=0D
>> >On Tue, Jan 31, 2023 at 10:08:41AM -0300, Martin Rodriguez Reboredo wro=
te:=0D
>> >> Adds a Rust equivalent to the handy THIS_MODULE macro from C.=0D
>> >> =0D
>> >> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>=0D
>> >> ---=0D
>> >>  rust/kernel/lib.rs | 12 ++++++++++++=0D
>> >>  1 file changed, 12 insertions(+)=0D
>> >> =0D
>> >> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs=0D
>> >> index e0b0e953907d..afb6b0390426 100644=0D
>> >> --- a/rust/kernel/lib.rs=0D
>> >> +++ b/rust/kernel/lib.rs=0D
>> >> @@ -80,6 +80,18 @@ impl ThisModule {=0D
>> >>      }=0D
>> >>  }=0D
>> >>  =0D
>> >> +/// Returns the current module.=0D
>> >> +#[macro_export]=0D
>> >> +macro_rules! this_module {=0D
>> >> +    () =3D> {=0D
>> >> +        if cfg!(MODULE) {=0D
>> >> +            Some(unsafe { $crate::ThisModule::from_ptr(&mut $crate::=
bindings::__this_module) })=0D
>> >> +        } else {=0D
>> >> +            None=0D
>> >> +        }=0D
>> >> +    };=0D
>> >> +}=0D
>> >=0D
>> >While this is handy, what exactly will it be used for?  The C=0D
>> >wrappers/shim/whatever should probably handle this for you already when=
=0D
>> >you save this pointer into a structure right?=0D
>> >=0D
>> >Surely you aren't trying to increment your own module's reference count=
,=0D
>> >right?  That just doesn't work :)=0D
>> >=0D
>> >thanks,=0D
>> >=0D
>> >greg k-h=0D
>> =0D
>> This was meant for setting the owner field of a file_operations struct=0D
>> or the cra_owner field of crypto_alg and many other structs.=0D
>=0D
>But shouldn't the macro kernel::declare_file_operations() do this for=0D
>you automagically?  You should never have to manually say "this module!"=0D
>to any structure or function call if we do things right.=0D
>=0D
>Yes, many "old school" structures in the kernel do this, but we have=0D
>learned from the 1990's, see the fun wrappers around simple things like=0D
>usb_register_driver(); as an example of how the driver author themselves=0D
>should never see a module pointer anywhere.=0D
>=0D
>> I know that increfing a module without a good reason is dead dumb, so=0D
>> I'm not trying to send things in a downwards spiral. @@@=0D
>=0D
>That's good, but let's not add housekeeping requirements when we do not=0D
>have to do so if at all possible please.=0D
>=0D
>thanks,=0D
>=0D
>greg k-h=0D
=0D
*kicks can*, at least I can take some ideas out of this, anyways, thanks=0D
for your reviews.=0D
