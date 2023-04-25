Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E975C6EE291
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjDYNPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjDYNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:15:06 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC3313C1A;
        Tue, 25 Apr 2023 06:15:04 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-440403d34a4so2070344e0c.0;
        Tue, 25 Apr 2023 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682428503; x=1685020503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqv8r/KFOBnoNWbUFUiDZTpYWxmph2Y+u4MhHtRun0M=;
        b=ctzWSSvCj4vVhD0Ybx0qlOxNqi9C5x7m7v/8XFMMh9Es8CtzsbZ1zqBQi3LBduNHZg
         sUusmouGhQJLLIcVoQYK27s1UZWgfu+K7Jrrdn3K6qFA1hIb1vtlpus2ZjCKSzW+r8Nn
         +pjxutdbxj6cZFtWfE6ILgKqpOUIh0banzxMPqR72qQ1bGSFJ7/0nnATmOA4kwzBMODQ
         FfPHoVA+jAHaK+TgCZJuLKhxw2C1hlV95n525LxdKY+QC/8EVs42fURaJ6GTK30/Q4Qy
         y4Pg2DTxOR+BnufXAPk+AD/WcPPcpkqmZWAvdqcrCG+ZfaNM49pIO4UEwKtlLyNYGaz+
         XnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682428503; x=1685020503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqv8r/KFOBnoNWbUFUiDZTpYWxmph2Y+u4MhHtRun0M=;
        b=YMILMFGQPtqfXTz0JLoNwXmDZCTlLvlv7gJjiTwoOJPnIYHAgYOiAhnNuqytY9iLqp
         HaHAcYub9tAISAqZoSnGeYSKB7YVjcXdpmxzL+XO5ba0g8aprh/P9OFwkqj6K0cGa+lm
         7wxPylD0BQqkEmm/eZHMAOVK8BmuwBivdOIhb+pxo56//oNTgdjJeQkZzY3iF5nzk5Qa
         AgAX3+rBWzY2sujIpi8KuxdCvLnbi+C9zs3EkoQO33hN4LHTP5l4OozwHiPMytaEBmho
         Ih9YKZGDQ+Ct+cXBamrNLB2weQ3qD4MNSbpu4o7KZ/fvFNK7h4IrXV1yF8CRJewMabUb
         YLXw==
X-Gm-Message-State: AAQBX9crboL8EM7cFK+GwJAYhiHvD86cdNy/YXP/EssGv5LmG8MDR2id
        J5LA6Ns8DgEgTygxAb0K81RI2pVVTJOq79dfQQEo/6nyXOnOIA==
X-Google-Smtp-Source: AKy350aanME0nMTNiM5fr4DFHHkaaB3EACxyhrJA3uB0MY8jl99vfng8dUxqcDxlYYiue3Q6E7DZYBnfyNJxlG5eh68=
X-Received: by 2002:a1f:c506:0:b0:43f:9aa5:a15b with SMTP id
 v6-20020a1fc506000000b0043f9aa5a15bmr4311156vkf.9.1682428503125; Tue, 25 Apr
 2023 06:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.1682405206.git.christophe.jaillet@wanadoo.fr>
 <ZEd8d7W6HnHE_66m@codewreck.org>
In-Reply-To: <ZEd8d7W6HnHE_66m@codewreck.org>
From:   Dan Carpenter <error27@gmail.com>
Date:   Tue, 25 Apr 2023 14:14:52 +0100
Message-ID: <CA+_b7DK1s87y-_-D3sQxteqJ+78uvKza-vgWGv9SmGm-tqz7DA@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: Fix a datatype used with V9FS_DIRECT_IO
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 8:12=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Christophe JAILLET wrote on Tue, Apr 25, 2023 at 08:47:27AM +0200:
> > Fixes: 6deffc8924b5 ("fs/9p: Add new mount modes")
>
> (Not a problem per se: but note this commit hasn't been merged yet, so
> using commit IDs is a bit dangerous. Might want to remark this in the
> free comment section so Eric pays attention to not break that when applyi=
ng)

This is fine.

The hash is constant unless Eric does a rebase.  When a maintainer rebases
then updating the fixes tags is just part of the process.  Often they end u=
p
folding the fix into the original patch at that point so the Fixes tag is n=
ot
required.  If a maintainer doesn't update the tags then the linux-next
maintainers
will notice and complain.

#GitMagic

regards,
dan carpenter
