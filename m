Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39872675ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjATUQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjATUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:16:42 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE544AED83
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:16:40 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so3117557pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RFrFWK6Yuz4He+Q+Dd7A5b23oGgMXF7yIM0sMxwjnok=;
        b=GEtp91po33uJf+p1P5Hc5s/2tlvFCr7HQo8fMdtWdFwOAKV/cTbo4kIAQnDjNlZDjU
         14vOnNGtt87RBXe3J1jpz5oAeoA31b2snqnMZHdgwsEtFs1hzmAdRFMriSqk3OVzCQiN
         nZQVn75hMHzF/9+WXFXvcDX9dIl3pVF/+sJQTfiM+xfVJLlR6LS2ggokyEeCGRBm6Igk
         v1VzjEnio1hBX2if1z5QARkEPtO0eK7lA4d0OyvLyhSy8ifs6a+zrGeZeyB3ymBIZLTS
         LAMgOey1bNWRBY9DgftgDtvvBLiUKR7p7PX7twdgkAsiumDnsGuMJIsaBH5JVIqEwTh6
         12Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFrFWK6Yuz4He+Q+Dd7A5b23oGgMXF7yIM0sMxwjnok=;
        b=x+L6v6xr5u++xv7M9d7UE2NW3LOqEgtZXKcpD++lP1sKy63vzlVKfmSW+42cz2Wa44
         UxyWZS5ivcc121tZi7a0ZbGjCxTrhdSDqTi8K0E5Q2WvOeaMrgesCj5edJOHeEIAjslf
         3/pwktIZ6Bf9phZV7/pQdmCWLuoDANmWqbr1dchvd0XfErMQOsPJE1K+eNcLMuisuFhT
         NW6r/e34pzI3rswsHagVOj2z1857P37YHfK29KRD+848+kTs+nXWXUdY05wNwhu0l7wE
         K91B4b+BkNA3+Xhcl4ntrDWccHq5cL2LMg1Sp/EzQc5xdHizIrJ9ZYFWtKcNHgkGTrvc
         3+XA==
X-Gm-Message-State: AFqh2kp/WsCgGdDcUnz1WPq9KIaty5FZScM2CBXGFPcwQL6egS2Jyki1
        NwK1FAQStlvrjywi5TnOhmuFI+gz5zf+ENB0L/H6
X-Google-Smtp-Source: AMrXdXuIJAna3jkn3HiysLFrRqrv7OboK2tJCEm7+hxOFIuo7F9HcZsXCZ1R/smMHmOl8DKk/3Z2TPkdG70lEMoVXF4=
X-Received: by 2002:a17:902:b496:b0:172:86a2:8e68 with SMTP id
 y22-20020a170902b49600b0017286a28e68mr1610008plr.27.1674245800136; Fri, 20
 Jan 2023 12:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20221207105430.248613-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhRSLh9y7KBCOhpvK2cwPmhyMr2dudhjcsEZ-Qmovi86Nw@mail.gmail.com> <Y8ru09KeMwwaU/IS@sol.localdomain>
In-Reply-To: <Y8ru09KeMwwaU/IS@sol.localdomain>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Jan 2023 15:16:28 -0500
Message-ID: <CAHC9VhSfr2Re6ZV6_USdvw__c1ou87uM6K_MF1wm-ENdEY7X5Q@mail.gmail.com>
Subject: Re: [PATCH] public_key: Add a comment to public_key_signature struct definition
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 2:43 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On Fri, Jan 20, 2023 at 02:21:04PM -0500, Paul Moore wrote:
> > On Wed, Dec 7, 2022 at 5:55 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > public_key_verify_signature() calls sg_set_buf() to set the signature and
> > > digest for the signature verification.
> > >
> > > As sg_set_buf() requires the buffer to be in physically contiguous memory,
> > > see commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in
> > > linear mapping"), mention that in a comment for the signature and digest
> > > fields of the public_key_signature structure.
> > >
> > > Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/crypto/public_key.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > This seems especially important considering the BUG_ON that could be triggered.
> >
> > David, are you going to pick this up?
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > > diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> > > index 68f7aa2a7e55..6d623e063034 100644
> > > --- a/include/crypto/public_key.h
> > > +++ b/include/crypto/public_key.h
> > > @@ -37,8 +37,8 @@ extern void public_key_free(struct public_key *key);
> > >   */
> > >  struct public_key_signature {
> > >         struct asymmetric_key_id *auth_ids[3];
> > > -       u8 *s;                  /* Signature */
> > > -       u8 *digest;
> > > +       u8 *s;                  /* Signature (in physically contiguous mem) */
> > > +       u8 *digest;             /* Digest (in physically contiguous mem) */
> > >         u32 s_size;             /* Number of bytes in signature */
> > >         u32 digest_size;        /* Number of bytes in digest */
> > >         const char *pkey_algo;
> > > --
> > > 2.25.1
>
> This patch has been superseded by
> "KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()"
> (https://lore.kernel.org/r/20221227142740.2807136-1-roberto.sassu@huaweicloud.com).

Well nevermind then :)

-- 
paul-moore.com
