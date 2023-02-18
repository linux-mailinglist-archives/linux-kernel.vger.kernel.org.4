Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21BC69B984
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 11:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBRKvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 05:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBRKvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 05:51:48 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB8120567;
        Sat, 18 Feb 2023 02:51:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ec30so1920516edb.10;
        Sat, 18 Feb 2023 02:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OcZz2dcJz7AXYQJXgunmrwsHzJqQg/ts6epTshEknHQ=;
        b=Pq+PjRH1DrOIeQZTVGORzlfvX+l1tMd6qBbyrbw8pMga5NYBL2lYhVOQUsAOqZ2dCg
         +3Mu94S9jwcj2AYwpWhmW969LehoA4cUhxRQ4dSf7tMU5+1sRNqMSNz9KXyj0Ib+YjQM
         ii2sE0i0vbrod46kB9P5BV4XXIPvUai1vKJXpcuiv/l8Z9S8E2W31+nQozQmGkuXKiyU
         SDdsI+Kh73+FB+a4US4UzZ4RYMa1PyKxnGZ3cuYDj3by28XNImmUCtgekncPfGA8GSn6
         jRh+o48ZQvPobxBI+bPG7UXW0bPrQpboxYfDhW/CsJ83CC4D854+eoNC4DV+MRF+9389
         LfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcZz2dcJz7AXYQJXgunmrwsHzJqQg/ts6epTshEknHQ=;
        b=jJxESDxnNHEGqOhD0F2N0i69MMOTjHWITKLBQOZ2aOqhNknAJyOiYMvsrmbOa1nK2i
         bsIQrHQQ67aDSqJWt/KaWRm+ZS/4OXaajRlLfHql8XcCulCw1uUOmn48qCOF9gEXntf6
         YX9l/BO0VheB883d6v2Yftf8WHPBu0rnIlbK99VTSSTF1pFkX6UwB6K2rkO8GJ3SNzSN
         pwGUg5uaNy2CB+J90QZrQjYPW9OyuRJG/msPRykh3dahiIAFC5fUeJ0H8yRDgixdbiq0
         2iveBHRCLKbF51CwMt3e8DPGzn0XYoVGF71U6ol763p4HMaWtz6hsYZXw7z4q9T+o0WH
         D4Ag==
X-Gm-Message-State: AO0yUKXHKwpYBuP3DI3K7zN+8+qj8MoD4DqxKNWeC33QnrsFQkfbA/fB
        Pr42aM4OGfAKG+WaeCDoWX1gafg0+ryolZ8FmEU=
X-Google-Smtp-Source: AK7set/7v/f8ZSBDYg90F8AjuSquy7tpwHf4x4f/sUM6O+HChIDO6DMUdcWqTT7Ysa26PEpHqS7l/1pLbPQu7x+zTwI=
X-Received: by 2002:a17:906:4749:b0:87d:ce4:eb7a with SMTP id
 j9-20020a170906474900b0087d0ce4eb7amr1647312ejs.13.1676717506115; Sat, 18 Feb
 2023 02:51:46 -0800 (PST)
MIME-Version: 1.0
References: <Y9e1PoEJgq3TPNtP@debian>
In-Reply-To: <Y9e1PoEJgq3TPNtP@debian>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 18 Feb 2023 10:51:10 +0000
Message-ID: <CADVatmNa+RnUOwUZovyEY4a=jc-yih=jUd8uMob2iWBOn_nPDA@mail.gmail.com>
Subject: Re: mainline build failure on arm hosts
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 at 12:17, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The mainline kernel branch had been failing native build on arm hosts
> for some weeks with the error:

This build failure is still present.


-- 
Regards
Sudip
