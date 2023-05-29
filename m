Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DEF7146D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjE2JFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjE2JFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:05:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F6AC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:05:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6cbdf16d2so19013895e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685351132; x=1687943132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6965SLL+03EPHpdw/iW57dwaJgfSUp/ti5KH8rsrEU=;
        b=oDcY5tfyWpwcPHf5SQ+/Be28tbLtei8/qxQ2Ht2QVeTm7s+OKRGK0zGX8V4MYdUnGr
         cdXQezEBS1y5/PV3uzTmSN2kqeiH/W377wpN4LzYfr2j7SSpj9Yvs9y0ko4Ph+nE/OBW
         IMLKLhsOy10kC1yIlGG0X/YVLkwxnPYZtCz0nhmlfdhuyXcAnR+jtjNsDfPth417MQWn
         04pSBgU2gRzE1BvBnrkvDhWB+/IWMLQ0cJT6wB4cBjOy1AOXn9gIsqsA5SCWzDP6/BUE
         Rxm0KfaghWONvKowTFwnxTCvPnCzKFy+ZzPIOctJarFXGpsT/vcTHTpbqH+zs56bo5lI
         PH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685351132; x=1687943132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6965SLL+03EPHpdw/iW57dwaJgfSUp/ti5KH8rsrEU=;
        b=MRd8xzrBTHq4QkvqkXcC7x6DTOZYWo3OffNwzUCp0fb68Zcf6E7tm9dtcJ9xCL8++7
         GNpU5frbe4E8T3mPg+hUB8awtxn04Ai0C3rPrP08Zc9d1hAeNz+m+RgvybdyUb+zD6F3
         q1y+lzo2cFZdMXPmX4xN/ylfrgfQtaVGtmg4EBhoOYOMZALWSZf402cwypAyhu0PeWjM
         jMI2LL746BNHgxt24y7JhbQGc0bDgla34ugWkm9LD5CLenvZAnA9EkLnIUUtCvwXW2ab
         rAYWwIL9vdU+1SdkQSJEH076NB3TDXZUeG/7BWzv0QgqG85iRIpnG8Rb348wVGpw7KCe
         Q8kw==
X-Gm-Message-State: AC+VfDwRb3+KOVc1SVE2dxLHNY2NlurhVeaTlrVle55CGVdSVoTrO/RA
        +fIDaP2VTtQFmSKBaicUUIEfpv8ybHYs7LqNW/OgMQ==
X-Google-Smtp-Source: ACHHUZ48aUtvUDHF7Y62jABDLZenZhLGOLjYbsuGUiPXsL+WZ+MvAmqIAUJ1VBoPcXCRXWrAPYD3Cljwvt7tYgcaTPI=
X-Received: by 2002:a05:600c:2042:b0:3f6:683:628b with SMTP id
 p2-20020a05600c204200b003f60683628bmr9617543wmg.3.1685351132282; Mon, 29 May
 2023 02:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org> <CAMj1kXEN0naaKAzGKBsJaL7LKa_4b+iP=g9YLcBK8qxZxy1C-A@mail.gmail.com>
In-Reply-To: <CAMj1kXEN0naaKAzGKBsJaL7LKa_4b+iP=g9YLcBK8qxZxy1C-A@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 29 May 2023 11:05:21 +0200
Message-ID: <CAHUa44EcVtMRp-894vQdHkNpnowvsKEQMZbr=axOJPig9zFhqQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] introduce tee-based EFI Runtime Variable Service
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 3:10=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 26 May 2023 at 03:08, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This series introduces the tee based EFI Runtime Variable Service.
> >
> > The eMMC device is typically owned by the non-secure world(linux in
> > this case). There is an existing solution utilizing eMMC RPMB partition
> > for EFI Variables, it is implemented by interacting with
> > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > and tee-supplicant. The last piece is the tee-based variable access
> > driver to interact with OP-TEE and StandaloneMM.
> >
> > Changelog:
> > v4 -> v5
> > - rebase to efi-next based on v6.4-rc1
> > - set generic_ops.query_variable_info, it works as expected as follows.
> > $ df -h /sys/firmware/efi/efivars/
> > Filesystem      Size  Used Avail Use% Mounted on
> > efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars
>
> Excellent, thanks a lot for double checking that.
>
> Jens, did you have any feedback on this? If not, I intend to queue it
> up for v6.5

Looks good to me.

Thanks,
Jens

>
> Thanks,
>
> >
> > v3 -> v4:
> > - replace the reference from EDK2 to PI Specification
> > - remove EDK2 source code reference comments
> > - prepare nonblocking variant of set_variable, it just returns
> >   EFI_UNSUPPORTED
> > - remove redundant buffer size check
> > - argument name change in mm_communicate
> > - function interface changes in setup_mm_hdr to remove (void **) cast
> >
> > v2 -> v3:
> > - add CONFIG_EFI dependency to TEE_STMM_EFI
> > - add missing return code check for tee_client_invoke_func()
> > - directly call efivars_register/unregister from tee_stmm_efi.c
> >
> > rfc v1 -> v2:
> > - split patch into three patches, one for drivers/tee,
> >   one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
> > - context/session management into probe() and remove() same as other te=
e
> > client driver
> > - StMM variable driver is moved from driver/tee/optee to driver/firmwar=
e/efi
> > - use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_s=
tmm_efi.c,
> >   this file does not contain op-tee specific code, abstracted by tee la=
yer and
> >   StMM variable driver will work on other tee implementation.
> > - PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
> > - implement query_variable_store() but currently not used
> > - no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_priva=
te.h.
> >   Other tee client drivers use 0 instead of using TEEC_SUCCESS
> > - remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
> > error message
> >
> > Masahisa Kojima (3):
> >   efi: expose efivar generic ops register function
> >   efi: Add EFI_ACCESS_DENIED status code
> >   efi: Add tee-based EFI variable driver
> >
> >  drivers/firmware/efi/Kconfig                 |  15 +
> >  drivers/firmware/efi/Makefile                |   1 +
> >  drivers/firmware/efi/efi.c                   |  12 +
> >  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
> >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
> >  include/linux/efi.h                          |   4 +
> >  6 files changed, 906 insertions(+)
> >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> >
> > --
> > 2.30.2
> >
