Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A773B2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFWIeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:34:16 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB39118
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:34:15 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-562eb0381d2so75863eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1687509254; x=1690101254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VfOZYjnomSo9q5VHX9+kAIXo4GkGFH/FUUb3pBSdsU=;
        b=QgS3X3DJxQOMrYcPrem/L90gdzSv0D+X18F1VXWDDbj0pPuz8zWDgQOXgpBM0pEfJA
         38G4+FCtksFQY6W6yU+IVxn7UI5ciB7IM+T+MRWKNzwSwkjPRpx4qYmuJqw1H1grQSja
         RVnTahp0J86+aokgbuYRoAM3FEkbmLUX4AdqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687509254; x=1690101254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VfOZYjnomSo9q5VHX9+kAIXo4GkGFH/FUUb3pBSdsU=;
        b=NC77vOLyUSwe0TGIUsrj+zuSHkK2rFn1k6GDSJW8uqRMQ7/lTSMpc84O9Z5RLqmBXh
         m2VJvPcuE03KoQrng4Wsh6KoNvV1+qOBcSMNm80/FXAja3NkG4SCdEA2ctvsA45B3p2J
         3A13WNKTHO0emeAJNwEN/UXvVa/0hZx6D9BLWdnE06BSzIiceUQc6+/ZIdCcEIRIZH+3
         4VgtE9gSGZ2nQDOsJGu77mAK/jBFEn/wjTay9KIVVlfgI/Hb+RKHfcCfsd13MviXXRJJ
         PltEZBSDSbCLdbvsEnf4VZT/BxEnwOloiqRO3LFVqT/71OkXc2RHn9KP66imfmO6vxlC
         QI6w==
X-Gm-Message-State: AC+VfDz2QFV6BhSZfgy4XtbTs+tdfpZQIsT7iY49218EZq8jpjBDW9AW
        UaErLxeWKub67MfPtul/KsRKRZcMrtfTtRELvFYYQQ==
X-Google-Smtp-Source: ACHHUZ7pTQsCjJlNSxOxtdDHphBEB4kzpuKwgH56v5UWf7ORubiHvZUo7Pf5b61u/B44T9klEfwdi3FHB7xe6l9AdU8=
X-Received: by 2002:aca:f002:0:b0:39c:8009:60af with SMTP id
 o2-20020acaf002000000b0039c800960afmr15684908oih.3.1687509254434; Fri, 23 Jun
 2023 01:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR11MB51262F07CD4739BDCB920483D322A@PH0PR11MB5126.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB51262F07CD4739BDCB920483D322A@PH0PR11MB5126.namprd11.prod.outlook.com>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Fri, 23 Jun 2023 10:34:03 +0200
Message-ID: <CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 12:28=E2=80=AFAM Von Dentz, Luiz
<luiz.von.dentz@intel.com> wrote:
>
> Hi Stephen, Alexander,

Dear friends,

>
> Looks like we have a similar problem as to:
>
> https://lore.kernel.org/lkml/20230524081933.44dc8bea@kernel.org/
>
> That said for unix socket it was decided to not allow it to be build as m=
odule, which is something I don't think we are willing to do for bluetooth,=
 so we have to find a way to get around pidfd_prepare, which seems to be ca=
lled due to the use of scm_recv (it is also used by netlink btw).

Ugh, yep. That's bad and we can't workaround it like we did for unix socket=
s.

Originally, Christian had objections against exporting the
pidfd_prepare function [1]

[1] https://lore.kernel.org/all/20230523-flechten-ortsschild-e5724ecc4ed0@b=
rauner/

+cc Christian

Kind regards,
Alex

>
>
> ________________________________ From: Stephen Rothwell
> Sent: Monday, June 12, 2023 8:02 PM
> To: Marcel Holtmann; Johan Hedberg
> Cc: Von Dentz, Luiz; Linux Kernel Mailing List; Linux Next Mailing List
> Subject: linux-next: build failure after merge of the bluetooth tree
>
> Hi all,
>
> After merging the bluetooth tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> ERROR: modpost: "pidfd_prepare" [net/bluetooth/bluetooth.ko] undefined!
>
> Caused by commit
>
>   817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
>
> I have reverted that commit for today.
>
> --
> Cheers,
> Stephen Rothwell
