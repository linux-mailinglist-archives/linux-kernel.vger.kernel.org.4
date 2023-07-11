Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF074E648
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGKFSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKFSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:18:06 -0400
Received: from mx6.ucr.edu (mx6.ucr.edu [138.23.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6354493
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1689052685; x=1720588685;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=J7mRGXWzjzUypZl1YrlY6WnKyilGpAMzn3Fsy5/G7mU=;
  b=C8eFCRN2IgoQRZWg5eqvL5yWB/gLra5NZMqUDbzUwnAKtl+/xfrOdNrE
   UNf94A2KqNA4bgcpdy28dZ5uqWBZ7icAAMdiQ6E1i0FXEeCmEDQ0OcdzJ
   EQiUAF82SRFxsb4JtTXGVQO8boCLo0SppF7mk2fOE+cCdXwkVJe3IrN2G
   Pc8eJFjKq/wqyuAY+wy2uX8NwgyitOqObY6l2u5k7HgeQmR2YOCj2MCkD
   GOfe6p6/YxyRDc3wFkzcYz6fSA2w6nLS6fiFHB58tp8DBLZSLLrOnio9e
   OwstSPMDA4ryY4EjvNs7Z37DHEvCZXLqa0BYJss4NEfGMYZe+hanhFG8E
   A==;
Received: from mail-wr1-f71.google.com ([209.85.221.71])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2023 22:18:04 -0700
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31273e0507dso3414989f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1689052683; x=1691644683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7mRGXWzjzUypZl1YrlY6WnKyilGpAMzn3Fsy5/G7mU=;
        b=tGMxj18PMGNBcN11yKaDN2a8+AEOJLpLBtgkukMkomxoAQW1SohL/wOlp+9LgZhM4G
         pF23yM43mJennj9ItvgP8QjvrMd+x8pPaEhJjALVGAfRog6uEKW1Lee/OvPzIlUpMqK8
         hHbP+QByT0LmmexpGnpvo0jMr+kjJ6wMkgrTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689052683; x=1691644683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7mRGXWzjzUypZl1YrlY6WnKyilGpAMzn3Fsy5/G7mU=;
        b=f+d21oZaGEtagL7pj6MPiS20jzoI+6TpqNX/D8Iu1k81Be9yZGgnuCTKvhjsam81TD
         Gsyw6KRKyFJfy9hA9QMDJgGAgeYZpvzFszgV1yJlcHRqdEbaAm+WLb4cQiw7WvIVGSkW
         zgXCaipjtOuEnTKnRTchLvpbWNCp9v3Qel0IQ/0ZRTH/fNU3RZ82dcfcr67CJQ4ZpE24
         K1zX65PsS+HDkXSzNxdIT/xpmXxBpBu6PuQ5KJSH13DtPNcg0HDymmqt7blvfTIMS4c1
         OBE7OdS4mcbKXmzte4J7F35qPj/hSD8qR0yMTe2y6QOfqVmbzuJc5LBw25ShMhqABtn8
         UB/g==
X-Gm-Message-State: ABy/qLbqKN2iaBzLDXSLgX5lU0drNMq4b3Oir6SaqqKnTrVWJObq2tXC
        zrd+/O729vllT1VWlGH8iaJyHD/LGioWEnfpLCCPC370fAty3uXoA8TnpkIBAnyfosVQdZqorLj
        SFhsnQR7hyVjMyx9HKmjRnWZc0Bk1y8ggzRJTtdzIVg==
X-Received: by 2002:a5d:504d:0:b0:314:1582:6eb4 with SMTP id h13-20020a5d504d000000b0031415826eb4mr13048371wrt.46.1689052682983;
        Mon, 10 Jul 2023 22:18:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcnTK0PswcZXZPjRlH+DrHN2Yu+zWHba4C9fsKbw7o/gHv+E+HaCsuq/OYFlMktrMxYq6kbtwbdKeqSeL4N7A=
X-Received: by 2002:a5d:504d:0:b0:314:1582:6eb4 with SMTP id
 h13-20020a5d504d000000b0031415826eb4mr13048355wrt.46.1689052682700; Mon, 10
 Jul 2023 22:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UBctBLWF14TsgT4OfanmnxTqbm9mNxyHhjJqpFo7c+kdjDsw@mail.gmail.com>
 <a8c6e741a9c704dad9b63e1e85136a8e6da09b44.camel@redhat.com>
 <CA+UBctANALC+FdNf+0v+hFZS5RPry=44LF3HQWKMYCxibgb_vw@mail.gmail.com> <770f630823c33f25ecddcbac19ef3acad82c2636.camel@redhat.com>
In-Reply-To: <770f630823c33f25ecddcbac19ef3acad82c2636.camel@redhat.com>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Mon, 10 Jul 2023 22:17:51 -0700
Message-ID: <CA+UBctA8iE+NWqgTk-v8K5-nAGzX9Zb4fJu+xP0PKmzyxzVufg@mail.gmail.com>
Subject: Re: [PATCH] net: wireless: cisco: Fix possible uninit bug
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     kvalo@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
        Jason@zx2c4.com, linux-wireless@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it. Let me do this.

Yu Hao

On Mon, Jul 10, 2023 at 9:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Sun, 2023-07-09 at 19:52 -0700, Yu Hao wrote:
> > I found that the related code is from Linux-2.6.12-rc2.
> > In this situation, the 'Fixes' tag should be 'Fixes: 1da177e4c3f4
> > ("Linux-2.6.12-rc2")'?
>
> Exactly!
>
> Cheers,
>
> Paolo
>
