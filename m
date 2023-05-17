Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A17570641A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjEQJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEQJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D85A19A7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A5164455
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67598C4339B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684315708;
        bh=rr7UrUKv6MsNvxzTtNIojMooL6eyVCpk6rsit5v94do=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=vM246Fushquk5gouKkigshr3EAMbRv5k+6T2mf9ynz5hZOYsQoWXYSh6tNPxtDf+v
         iLPmen+qcX1e3xvTaeZwnYxySlM0DXQ74jIbal1MlhneagaizcrlOObr9cGhZr0soY
         dHVEBtkyocuipyvAupgGOwcS0ayGLFCJ/70eLpFiuUvmrtQAfESch/pUKhMBCM26Ay
         1jrxh5svfDrFRMd8vD9j17TnQsraZ7fZRj0AGy1amzqy9+hZMybVWKLwHD2lLopbnB
         X9YRi+tqHBydjFH4zesa88oRu/Wrs6BfJp+dmqoGZTD4cUyXHqqsDvAlbz4RnH5ERV
         0eNcFeA+SaniA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-55239f43426so225308eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:28:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDwzNM0Ty59B/gkUY+3OTGlHrJOL8MUJ8KUvZgOzKgrAMlflay1i
        fWZPDLoov/wgJAYHlEtiPJtb5jAaK/iKPlCeYJM=
X-Google-Smtp-Source: ACHHUZ689Z4V+J+eaquFY9rTV2Nm4RWEjGVOOgXAZa5HwBY+pywFHqDyzbP7UyBnODapucnUDebRImcWHU0kmhIkSrM=
X-Received: by 2002:a4a:3803:0:b0:550:9895:fe77 with SMTP id
 c3-20020a4a3803000000b005509895fe77mr9013829ooa.9.1684315707613; Wed, 17 May
 2023 02:28:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:290:0:b0:4da:311c:525d with HTTP; Wed, 17 May 2023
 02:28:27 -0700 (PDT)
In-Reply-To: <20230517-keimen-teesieb-d606296295ba@brauner>
References: <20230517070739.6505-1-linkinjeon@kernel.org> <4125c148-a4f4-edd2-3009-0283246f8a95@gmail.com>
 <CAKYAXd_=kXjKnmfiSEuTLG0fd6Ezj+7_R_ZSWntbvUgQ9Hyx0w@mail.gmail.com> <20230517-keimen-teesieb-d606296295ba@brauner>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 17 May 2023 18:28:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-664AUGbKVO9MUJ_ZNSQNQZg9xL+L8QK147=2TbtJpaA@mail.gmail.com>
Message-ID: <CAKYAXd-664AUGbKVO9MUJ_ZNSQNQZg9xL+L8QK147=2TbtJpaA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: Add myself as a reviewer
To:     Christian Brauner <brauner@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, anton@tuxera.com,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-05-17 17:43 GMT+09:00, Christian Brauner <brauner@kernel.org>:
> On Wed, May 17, 2023 at 05:26:59PM +0900, Namjae Jeon wrote:
>> 2023-05-17 16:37 GMT+09:00, Bagas Sanjaya <bagasdotme@gmail.com>:
>> > On 5/17/23 14:07, Namjae Jeon wrote:
>> >> I'm volunteering to help review patches for current unmaintained
>> >> ntfs filesytem.
>> >>
>> >> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>> >> ---
>> >>  MAINTAINERS | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index e2fd64c2ebdc..c2cecb2059d7 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -14928,6 +14928,7 @@ F:	drivers/ntb/hw/intel/
>> >>
>> >>  NTFS FILESYSTEM
>> >>  M:	Anton Altaparmakov <anton@tuxera.com>
>> >> +R:	Namjae Jeon <linkinjeon@kernel.org>
>> >>  L:	linux-ntfs-dev@lists.sourceforge.net
>> >>  S:	Supported
>> >>  W:	http://www.tuxera.com/
>> >
>> > Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Thanks for your ack!
>> >
>> > Anyway, what about also adding linux-mm list so that akpm can
>> > pick patches?
>> Hm.. I think that MM folks probably don't like to see fs patches on mm
>> list...
>> And as far as I know, Christian is going to picks up the ntfs patches.
>> Christian, right?
>
> I've picked up your patch already. A notification should be sent
> shortly.
Thank you!
>
