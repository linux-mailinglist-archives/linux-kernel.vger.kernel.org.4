Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FDA6DD3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjDKHMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjDKHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:11:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EC940FF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:11:16 -0700 (PDT)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF6453F232
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681197070;
        bh=H2cQrPMQwRi8jarZD975xdrVJAqj415FcPf9JaE0c7U=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=TcUpqy7T552lvZKejNXbGxKvgJ1D+4DMKSaXSoyBmdU4ol3ViHrrc4PGJYXN0xQ5X
         8Grq3oUDabKlZNCepoABnD6VmK4pP6wzqxHXRS4RtLQT3K4qDq65nFTU9GNt9OSec4
         rh7Kk2Gt2WdsOa14OyFXQC6i92nHOMHVKxsyUN8Wh27LFL7nFI+TMkSF49aHPhLhlN
         Ft58JH3JWAFmN02jy1/oRhGG1wziytogc3J+GgYr7Z49jRopmEOj8ab3DgKeEZUdqi
         uWlcpqpqnvwSLV25rehuDHoY33TAbwjIIpzY8TJfJkyIAmWelG3rUAFWRPlKNywgJb
         5fHfaiAgwD+Ig==
Received: by mail-oo1-f70.google.com with SMTP id a43-20020a4a98ae000000b00525456d55f7so2376754ooj.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681197069; x=1683789069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2cQrPMQwRi8jarZD975xdrVJAqj415FcPf9JaE0c7U=;
        b=XwIDAD665P8ZKx3gF+vqnFM8Ii3Tfn4QNki6IL1Q9frQCiho8LQu8uv6y+nHhK2l6G
         oZRQYUSg7FAROmwEdzFidGv86COMc3Qj34hEXI8mVB1H56BNSZZ7kZpKMC/dEI7ribM5
         uyB9a1/aukVZO0aUIoGzoD5JkIvCEhnSRHQnqlILdC4gVhmS6G3z0442hDVZE71sQK4x
         NkWwYbSIDURppBacFEC3NOIRGDdrnAiPBGxYuZWBaXBDc5Pag4EeEm8dN78aZ/KmvYb+
         pjooXlgsesd1oWHx97R0/m8x7E2OmqNHSWSouTlOzYSGwDRK8aVeiJ4Xi3758w51tfL3
         Cbuw==
X-Gm-Message-State: AAQBX9eKVaecoHN1g+8DtCoW9unDAb5P2KPLe5LZs5+jvMSAp9He35+4
        vdouOPoaJJ1oe+lF55aWRV2ngAftnfUUXgKFyezZ/mX0E3TxLOIcOC0oz4qa2JPEKpfVO5wAC5Q
        HurN3wfHJSN2XrgVW6BT8/m+1CiIcpWMasniM2y7Eww==
X-Received: by 2002:a05:6871:828:b0:17a:ce6b:726 with SMTP id q40-20020a056871082800b0017ace6b0726mr7752375oap.57.1681197069537;
        Tue, 11 Apr 2023 00:11:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZDpfH1S+/bTj8wmoZi6wmxQ2DDVizMlGxNu+x8TONxy1ApAhRI2g3WiK73fTHA1Yt6F2NnBw==
X-Received: by 2002:a05:6871:828:b0:17a:ce6b:726 with SMTP id q40-20020a056871082800b0017ace6b0726mr7752366oap.57.1681197069290;
        Tue, 11 Apr 2023 00:11:09 -0700 (PDT)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id e5-20020a4a8f05000000b0054157801d51sm5362192ool.38.2023.04.11.00.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:11:08 -0700 (PDT)
Date:   Tue, 11 Apr 2023 09:11:06 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
Message-ID: <ZDUICqLhv6uSk9an@righiandr-XPS-13-7390>
References: <20230210215141.108958-1-andrea.righi@canonical.com>
 <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org>
 <Y+daEOZgaiF3IMTX@righiandr-XPS-13-7390>
 <4E6FDE1C-47B6-46A6-AF31-28AEB2348344@kernel.org>
 <Y+entVlMoV83vyzz@righiandr-XPS-13-7390>
 <CANiq72nQ4-md=KxtUcz3jHDXhLUdw1JxgbSKp7QsN0QKS3pV1A@mail.gmail.com>
 <ZC+x8pqUVzWQ35fv@righiandr-XPS-13-7390>
 <CANiq72ngN9bAiWaVVyJkkEK_WAoTQVb5mmYLMqs5PK7pu6gV9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72ngN9bAiWaVVyJkkEK_WAoTQVb5mmYLMqs5PK7pu6gV9A@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 10:49:58PM +0200, Miguel Ojeda wrote:
> On Fri, Apr 7, 2023 at 8:02 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > The check (< 16) looks correct and the comment also looks correct to me,
> > this option will be removed in clang 18, as mentioned here:
> > https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0-rc2/clang/docs/ReleaseNotes.rst#deprecated-compiler-flags
> >
> > (Maybe we could add also this link as a reference)
> 
> Thanks for taking a look -- Kees' link added!
> 
> I removed "(as the name of the option suggests)" from the commit
> message, by the way, since the name of the option suggests the
> original `-ftrivial` option was to be removed, not the `-enable` one.
> If that understanding is wrong, please let me know!

Yes, that looks more clear, the name of the option is a bit misleading. :)

To be clear what is going to be removed is
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
in this way clang will be compatible with gcc and they can both use
-ftrivial-auto-var-init=zero.

Thanks,
-Andrea



> 
> Cheers,
> Miguel
