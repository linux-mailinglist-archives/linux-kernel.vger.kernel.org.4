Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F97474B306
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjGGO02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjGGO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:26:26 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB40E72
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:26:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-345d3c10bdfso7229595ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688739960; x=1691331960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8zOo4D7CrF3Fq7dS/X/Z4THsObN775yaluRka+o+qQ=;
        b=H0Yq65cvVrCyR5pi6ERAN7hGmCVrvgii0bpZjVUOYChrJmU5EKpYGFHiLDvTJ8bzdC
         koQnzvJyChtDS5cOEhSyIQaV8dOVJVsgRIAEbBAyAcJtkvfnjP+mzSG1q/8XPVg63SV4
         HXRR2UZCvwBen+Zo7V2P0Vxuxh00xT/eSTPQ66xlCWlDyJrml+CBRDDgwtx5dP6QAWi+
         A2618sG3Qw1folZyfJEYBo+dYLsFcWieCtdATDE/MF53WrmIIWUpxRlaeFbOktglr/AF
         NPKpSTVx7aEkl6hXDN3udp5DIkS/AVT+rvhadE0g20ci9gauyelpXf+HUlZx6XgvDraW
         niMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739960; x=1691331960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8zOo4D7CrF3Fq7dS/X/Z4THsObN775yaluRka+o+qQ=;
        b=dCjXjYZUHbAIyvFF6okuY6NG2BNs9cAAeCbDNcygLLtVVLSkEmyd8F+muO7frhGbID
         teqbCOSc0PlKM8oI8uCi5ScpLRNOlXx8iehcF+DB9HLXEfOkpxNyvBLQCMHLq5ogY3Nb
         PgMUjqU10zCOJY5n3aqyOACAGbjqB54Y58r2KDnpvz9moWJ8BQ5aAMm0RJz2XTvHPoCj
         bE7IreBulYi1FzYMvKrZQNPT/qcjFrcJZeL5Nd7Ag8j5Z7gVzQBC+IajqG2a0uBIMQql
         VoIRDdVTHbxI0twsGGS5YR9HdvrGySp5rbTh/8PH9i8ZP7GXfpIhJLqvW+yhS0NIpOFs
         rnkg==
X-Gm-Message-State: ABy/qLacAgF93N5QzrNyUSroaCNQ1XRrQQGz2I4sIBenc+rX0+5Q53on
        izrm4+KZsyS9f38eS2oJI7HFgYUc8hXngS8tyWzoBWIC1qrjaU6yjUU=
X-Google-Smtp-Source: APBJJlHaE7IHJaxHSJSf0ShE7mF4jdMOzymySDMkkwwWI5PrdZsWK3w+PzkJNpoJ4kvvPL+ob+sqgbPrQYTRHeJh8ok=
X-Received: by 2002:a92:c647:0:b0:346:49bd:7b72 with SMTP id
 7-20020a92c647000000b0034649bd7b72mr1046282ill.14.1688739960033; Fri, 07 Jul
 2023 07:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com> <ZKfFVfZovt4PnMsy@dhcp22.suse.cz>
In-Reply-To: <ZKfFVfZovt4PnMsy@dhcp22.suse.cz>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Fri, 7 Jul 2023 22:25:48 +0800
Message-ID: <CACSyD1M9rSadO7xb8-H0dU2-xtrZnJMBgqEMTSHhE6M5vFgC-Q@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/2] zram: objects charge to mem_cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please state the objective you are trying to achieve by this patchset.
> It is always good to summarize the previous discussion and mention what
> is done differently or how previous review feedback has been addressed
> but the overall idea/purpose should be always explicit.
>
> Please elaborate more about both.
>

Thanks for your reply.
objective=EF=BC=9A
the compressed memory of zram charge to the cgroup of the user.

summarize the previous discussion:
[1] As I can see, Michal's concern is that the charges are going to fail
and swapout would fail.

The indirect use of zram is in the context of PF_MEMALLOC, so
the charge must be successful.

[2] David's concern is that if there is a page in the BIO that is not charg=
ed,
we can not charge the compressed page for the fs->zram and whether
the recompress case is charged.

In the new solution, the recompress case can be charged. But if there is
a BIO not charged, I'm not so sure, to be honest.it would be great if
someone with more FS->BIO experience could comment.
I have to review the relevant code to check it.

[3] Yosry's concern is that the previous patchsets are very complicated,
and do not have wirteback support in zram.

For the new patchset, charging becomes very simple, and zram supports
writing back to disk.At the same time, I am hoping the use of zswap
without a backing swapfile can be enabled.

To summarize the new patchset:
We charge compressed memory directly in the zram module instead of in
the zsmalloc module because zsmallc may be used by zswap, zswap objects
has been charged once in the zswap module, so zsmallc will double charge.
