Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9115FE87C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJNFso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJNFsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:48:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1AF18BE3A;
        Thu, 13 Oct 2022 22:48:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fy4so8259276ejc.5;
        Thu, 13 Oct 2022 22:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hOxl8dM1RanRcVqNQmYaXM1GEFKqKyYhjpkgbV/FC3I=;
        b=X9GQLQL8jTxfVVUHcajZw61l8U+m50gGUuQXSTTKisGKJmDmRb8iChFWUP36UVrKso
         EdsHbKY0tdx5YSevUWtN2kEH7e3GrSa8eQ0TpPh873yPbI7bMcq6DPmESLcGBtRhRWZw
         t5V/fqueoNMAItW5NJeX/7URMRvBru6Gw02Qb+mtG4Ev/Lg7otlZicSrX/fCKZ/g4NeT
         Z2kJCXIHMRCE0Cep+3+pFiAeX8TR8eYJSH2ts7Co5e1Ej/MBBKSb1KZZhMjBHKOGw2Hz
         nlvaukeEpMMK6H4ADHBkPdZI3HzAdHITyQshm7KHMlvHwydsYAVNU/ySolV1JuCiFB5/
         6n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOxl8dM1RanRcVqNQmYaXM1GEFKqKyYhjpkgbV/FC3I=;
        b=l7YH/F0vpfkkUvbb1TKNA4GZp8lVSgI+WUBZSGQMGIScRubOXe0zkFxfE99UgQ7Nur
         O4Bl2mhWgsP3igZscGbc3oezAN70IAu7jJXyDrILoyrXswKqJsMilOxxfZc6ZI7T9ecN
         SwbkcQwliT26jU/l3fACd4DOyiGzngbC18W7oEwjekW5sL8IpIkUYU8o9HMdfu8KNB4Q
         mT68KG9W5NEn3666W79FQYHx4GGosbRnefKhQIPjN79KP60gGx0s5dvzGVa8cMJ28v8X
         hDfyPJVmo9pOy610kTD9D2QZOpq6XQQS1KCXg3CR+1RKDRh/tA3/9FNkgPkKSXq/SmnZ
         bTEw==
X-Gm-Message-State: ACrzQf28Urorv8rD6ehXErHc5ywgU1wpS8nq0lgYjndHuPvVkReJwN8D
        0uUhtHsTGGleum+coO+bj5s=
X-Google-Smtp-Source: AMsMyM6dmo97pNa4LFPKvaikQDBWFG68BewMktzXUtLdl1VziNfP4QiefygvBap/FOLB+J+rCeDEzQ==
X-Received: by 2002:a17:907:c25:b0:78e:1a4:132 with SMTP id ga37-20020a1709070c2500b0078e01a40132mr2275492ejc.521.1665726518717;
        Thu, 13 Oct 2022 22:48:38 -0700 (PDT)
Received: from linux.fritz.box (089144213149.atnat0022.highway.a1.net. [89.144.213.149])
        by smtp.googlemail.com with ESMTPSA id k13-20020a17090627cd00b0077826b92d99sm987427ejc.12.2022.10.13.22.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 22:48:38 -0700 (PDT)
Message-ID: <8678f69aa94003b357c4c8ef42cd6ce5c7487f8d.camel@gmail.com>
Subject: Re: [PATCH] ufs: core: Disable auto h8 before ssu
From:   Bean Huo <huobean@gmail.com>
To:     =?UTF-8?Q?=E9=AB=98=E4=B8=A5=E5=87=AF?= <gaoyankaigeren@gmail.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Oct 2022 07:48:34 +0200
In-Reply-To: <CAFN68yVdwrECaDvNuok_4V-54UZUJU9+dn5icaiPdj6BXEZuVA@mail.gmail.com>
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
         <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
         <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
         <bee1807b7d072b221c44ac8c2ed8064939d33696.camel@gmail.com>
         <CAFN68yVdwrECaDvNuok_4V-54UZUJU9+dn5icaiPdj6BXEZuVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-14 at 10:44 +0800, =E9=AB=98=E4=B8=A5=E5=87=AF wrote:
> " UFSHCI has idle time before bringing Link into hibern8 mode, " I
> think=C2=A0 ufs put the link to h8 during the time


no,  it is ufs controller. see the ufshci spec:

"Auto-Hibern8 Idle Timer Value (AH8ITV): This is the timer that UFS
subsystem must be idle before UFS host *controller* may put UniPro link
into Hibernate state autonomously. The idle timer value is multiplied
by the indicated timer scale to yield an absolute timer value. ....

...
Any non-zero value will enable Auto-Hibernate idle timer.
UFS host controller shall put Unipro link out of Hibernate state when
the link communication is required. The mechanism to decide when the
Unipro link needs to become active is host controller specific
implementation, and is transparent to the software."


