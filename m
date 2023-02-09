Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957266913AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBIWrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjBIWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:46:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B1A2734
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:46:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j1so3536944pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9g2yQtWzAVH6ZOpDsD/Sskemui/XDqoYgj9fWj/hkxU=;
        b=Fcjg1IeCP5a42XMH+PhI6FfYg/ZEC4FgpEwO2V6GvMNyMrvAcl9kKvcS01KBHSx82+
         OZZKtrI7t5/KX66FOK/1hHFW0nVKD4IBJf/vEIg9028FjBGjeq+MxlG8wtJRbGXCe8Zv
         ssz7dnJgd1z50RC8sOXXUWNvCagc3zNzWh7y6NFro6FvBBXOx3hjqr8K9oWb616ub3vD
         nXXLKpIF4/k+oT2CQZYhei6jOVDegdDoUAyaqgD8+2AB3UMhfTdFu+tjTrdWCiYHd/UC
         /CDS2BY/9+s5PZrlNrGdQPNrWzw61I1u1EAxVPSdCY2ZXwyX7YgR1ABL5UcgKsWMwx8r
         KwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9g2yQtWzAVH6ZOpDsD/Sskemui/XDqoYgj9fWj/hkxU=;
        b=o24RtH31otUgOiyV1rNf/gP5+ZWwtJsObRiU6BK3jJoBNvjYbeKCu7eBgoBLpp9vYy
         iVqWY6kpa5pyMSjdJk4VfLG/I3uQojPe/g9qgQ0fkj1eIYLIlKB5AfucToAf876gp+lF
         zG2QioZIe2udkJYwtgXCUSOm8Pd9tyLa6C8va67XCSPFfc45aaPaSK3BAP0883ob4kzj
         v2Ee78aX+0FRI8iZTXvZuV4+4kuSPFo92pXoM2+AZjCg15IMo+GFUbGt8ZrtURg0SQeP
         ssmtREolM7/8dTLwKhMu4a2JYREHCoMbq34g1SeaN1aTBvBP+SQLhh7UDCfb4xbk0sdJ
         iR4Q==
X-Gm-Message-State: AO0yUKUTtcowtbhnLgEmpvt7a0yzIDQPIjDOSxohxf168x1qnnqxq+VW
        5//FeTUywT2upLU9ZTRK78qrMycpQE1LMe2LEs7o
X-Google-Smtp-Source: AK7set+5+CGbyUdx+XEn7CyiOAlZsrmdC59etIZEgrVyrqoicPNTGQjjG1Gn3JnsMH+LPETc4+h+vPAftTT77wQ7BnQ=
X-Received: by 2002:a17:902:70c4:b0:198:ff55:2ef3 with SMTP id
 l4-20020a17090270c400b00198ff552ef3mr3307989plt.27.1675982803339; Thu, 09 Feb
 2023 14:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20221227142740.2807136-1-roberto.sassu@huaweicloud.com>
 <20221227142740.2807136-3-roberto.sassu@huaweicloud.com> <Y64XB0yi24yjeBDw@sol.localdomain>
 <d2a54ddec403cad12c003132542070bf781d5e26.camel@huaweicloud.com>
 <857eedc5ad18eddae7686dca63cf8c613a051be4.camel@huaweicloud.com> <Y+VBMQEwPTPGBIpP@gmail.com>
In-Reply-To: <Y+VBMQEwPTPGBIpP@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Feb 2023 17:46:32 -0500
Message-ID: <CAHC9VhTYeqCB8roaNvWUYJeKPwT35ixJ8MMXBe0v0+a9o8CXWw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()
To:     David Howells <dhowells@redhat.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>
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

On Thu, Feb 9, 2023 at 1:53 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Feb 09, 2023 at 11:49:19AM +0100, Roberto Sassu wrote:
> > On Fri, 2023-01-27 at 09:27 +0100, Roberto Sassu wrote:
> > > On Thu, 2022-12-29 at 14:39 -0800, Eric Biggers wrote:
> > > > On Tue, Dec 27, 2022 at 03:27:40PM +0100, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >
> > > > > Commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in linear
> > > > > mapping") checks that both the signature and the digest reside in the
> > > > > linear mapping area.
> > > > >
> > > > > However, more recently commit ba14a194a434c ("fork: Add generic vmalloced
> > > > > stack support") made it possible to move the stack in the vmalloc area,
> > > > > which is not contiguous, and thus not suitable for sg_set_buf() which needs
> > > > > adjacent pages.
> > > > >
> > > > > Always make a copy of the signature and digest in the same buffer used to
> > > > > store the key and its parameters, and pass them to sg_init_one(). Prefer it
> > > > > to conditionally doing the copy if necessary, to keep the code simple. The
> > > > > buffer allocated with kmalloc() is in the linear mapping area.
> > > > >
> > > > > Cc: stable@vger.kernel.org # 4.9.x
> > > > > Fixes: ba14a194a434 ("fork: Add generic vmalloced stack support")
> > > > > Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> > > > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > ---
> > > > >  crypto/asymmetric_keys/public_key.c | 38 ++++++++++++++++-------------
> > > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > >
> > > > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > >
> > > Hi David
> > >
> > > could you please take this patch in your repo, if it is ok?
> >
> > Kindly ask your support here. Has this patch been queued somewhere?
> > Wasn't able to find it, also it is not in linux-next.
> >
>
> The maintainer of asymmetric_keys (David Howells) is ignoring this patch, so
> you'll need to find someone else to apply it.  Herbert Xu, the maintainer of the
> crypto subsystem, might be willing to apply it.  Or maybe Jarkko Sakkinen, who
> is a co-maintainer of the keyrings subsystem (but not asymmetric_keys, for some
> reason; should that change?).

It is problematic that David isn't replying to this.  I have no idea
if it will work, but I just reached out to him to see if I can draw
his attention back to this ...

--
paul-moore.com
