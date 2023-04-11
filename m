Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0026DE670
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDKVcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKVcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:32:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499092111;
        Tue, 11 Apr 2023 14:32:07 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y69so16633887ybe.2;
        Tue, 11 Apr 2023 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681248726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2AeehAzjo1XWgey2mtP2K8MeojiY/T/jdebWdr9HGU=;
        b=nTuxeeTkOaTh4UKxAMzMhw14CaUH/YVnvgfV6mBh/W6bgj8FknEV+cydJRz8G5JS9P
         2t8S+q97UenoRp3y6dZAgX8YBBINrI8zFDR/yHb4SkwhXSQh4FMVZqahhQz8k+oS7A1j
         KB+/b7grsqKqz5a7HXsj1U4c6SktgpwBmFicRqWIDHfNNQgtG2OFpxgs+9N9CD0fkVlI
         NSihbQ17kmRQVXQam9ySN2OThNJICxCVWipde6PyB7BeR6w8Yc462u7GXv/h8Eum1j3o
         GP7suyvkcyMP/g4Dkvk6W+V31SvRXJmVbChmdlJAXUgb86c6fYetPxz/FcXMel9X0cnC
         WBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681248726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2AeehAzjo1XWgey2mtP2K8MeojiY/T/jdebWdr9HGU=;
        b=SUSl+KK1Fn+MV6tFQ031B/HDwz68jZJFle9Mwpn80CQL6xOIfn5Ocsda/acyVmhGC7
         Xooddo/Jaa4ZN3/aAnfFbhdbEWVSfoQYV7gYKbWRv8YG0tQCqcSSjwoZ83kOu+iP14bE
         WgkiqsQlleXfd7X+OKTXZ7OzBkiXG9e0zGxzKCxftiNW5aVSEXV94MfIReVZCOaza68Y
         DB9jdQ/jhM8qrlBNoSxvZFaW2Mx36VjdwTgKwiJQjG2z6KvJr8jgYbw7tRWR8qWumcC1
         lstx1XOEMDmhNADRb+UulVAxuRB62oix3jI9jKTUu18u1QLqY/DQOqf9Q7RmrOHQcp0n
         Lr7w==
X-Gm-Message-State: AAQBX9fH/NHbqpIYP+nN4Le4mJV0lD26JXw4kYtbhRZj0ks6h37sa9aS
        430b2hIKV19ImKMktJjGDkVWDFiwAg2mV3fwToE=
X-Google-Smtp-Source: AKy350aK6UlfG1lnP4BiImEDFb4QbO4fzXqaWXdQCzI6Qf2JN5YPOy9LO9KGuFXvG7Eet6kQfTncWfIJZAhz/fz+BOE=
X-Received: by 2002:a25:744e:0:b0:b8b:f61e:65ff with SMTP id
 p75-20020a25744e000000b00b8bf61e65ffmr2597772ybc.5.1681248726503; Tue, 11 Apr
 2023 14:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230410023724.3209455-1-jun_c@hust.edu.cn>
In-Reply-To: <20230410023724.3209455-1-jun_c@hust.edu.cn>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Tue, 11 Apr 2023 14:31:55 -0700
Message-ID: <CABPRKS9TbZO7NmknHfNEaxuY3EGGmR_NOcbBuM1ooba_R-3yiQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: silence an incorrect device output
To:     Jun Chen <jun_c@hust.edu.cn>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Justin Tee <justin.tee@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

Broadcom no longer supports LPFC_SLI_INTF_IF_TYPE_1 adapters, but the
patch looks fine.

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Thanks,
Justin

On Sun, Apr 9, 2023 at 8:14=E2=80=AFPM Jun Chen <jun_c@hust.edu.cn> wrote:
>
> In lpfc_sli4_pci_mem_unset, case LPFC_SLI_INTF_IF_TYPE_1 does not have a
> break statement, resulting in an incorrect device output.
>
> Fix this by adding a break statement before the default option.
>
> Signed-off-by: Jun Chen <jun_c@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.=
c
> index d062220d3232..da3a45441639 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -12105,6 +12105,7 @@ lpfc_sli4_pci_mem_unset(struct lpfc_hba *phba)
>                         iounmap(phba->sli4_hba.dpp_regs_memmap_p);
>                 break;
>         case LPFC_SLI_INTF_IF_TYPE_1:
> +               break;
>         default:
>                 dev_printk(KERN_ERR, &phba->pcidev->dev,
>                            "FATAL - unsupported SLI4 interface type - %d\=
n",
> --
> 2.25.1
>
