Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72795FCF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 02:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJMAIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 20:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMAIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:08:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A1FE939
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 17:08:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s30so509289eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skymem-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6rar038TuQ0C6/6CRJzUpoyinwUQGW/xPOhxsBuZck=;
        b=tp3bPdMPxa2lVR5q4VmqhMQrQ47mnHZ5LIgXP74lktYJNNWcttUrAoe6Y5C22MLJ5g
         /D5ZoCq/NQPzH6ECttjcnn7tPx/CYuTnpnpJkd/PbmbZ6RK1+BO5sNJuanMntgwb0x83
         BcZcQ83En2/DK1/eF2X58jrutNlOvYPcbowpVFouFN8T0T/Rm+yEhgKuQr2YjehbvUHd
         msWFEPcBAFvx3EnDppT7euu97aWYnmXVM+RTUmmkY6s8yr+0bxG1sWeylO21tZaZtPdT
         mr00qYL9IYxyuaVJVun/6b+u4hIQcGMBrj7Y4BMLAo2n6o8I2mXeuNYACmLmFqTaCLzx
         Thsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6rar038TuQ0C6/6CRJzUpoyinwUQGW/xPOhxsBuZck=;
        b=KMammN5z7/8O9mLrWKfrr0qQ4PJesUHy2h0b/rCwkosFbU4FokWhTUP9PfIjQbpdve
         umH9EhgqyAvikHz1zSN73TuZ+pQ1xSIyBIljehwQ48lUglk2/yDouTVHIpJDlQlhG/93
         3mNeAV6NQHxc4rAtGB77zS2EAV4k8ziXKLBIFvBuoeHxsDeordEZHX0eztYzfrdBbmBu
         4ZdCXWa/G5aKf619X77v1gnugdXG5HCvhIbT8P7o1lXTnGlUoB7RXWrYYlVuEj/1C977
         e3HMuhO30WMsqDfXzpq0KO66hVVLF8k8JkAiv1bX3LJKyeFwLAu5WBGGHPJ/EYhsEhoo
         HqcA==
X-Gm-Message-State: ACrzQf2W1ktOB8Yers0VDHKzqfOE8O+U/5++0WzxCcydLbsttXQRjSJB
        G4DM0xHEXiI9MDio8XRPX8uARThkBtQaEN2t/oM4Tw==
X-Google-Smtp-Source: AMsMyM67e3Wn4tA+v6BdZlIY/YZ7zjSME9IrVNT0ZlADVbMQ5lHAgF2RKwAmkZ2m+XbCF4j3S31NfT0TxTiaOedC/hw=
X-Received: by 2002:a05:6402:410:b0:451:ea13:4ed7 with SMTP id
 q16-20020a056402041000b00451ea134ed7mr30745229edv.262.1665619699024; Wed, 12
 Oct 2022 17:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221012191201.GA3107702@bhelgaas> <CADVatmNcUwZO3fmi=gU-ShHYCdQDwoWGcYWFg9oMVxdZdA98qQ@mail.gmail.com>
In-Reply-To: <CADVatmNcUwZO3fmi=gU-ShHYCdQDwoWGcYWFg9oMVxdZdA98qQ@mail.gmail.com>
From:   Info Skymem <info@skymem.com>
Date:   Thu, 13 Oct 2022 02:08:08 +0200
Message-ID: <CAKvd=_iu_8u=6vfZLFw5A+rsAO9-QmuUSE5TRKEbTY_Zu33QCA@mail.gmail.com>
Subject: Re: [Linux-parport] Add linux-parport archives to lore.kernel.org?
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-parport@lists.infradead.org, Tim Waugh <tim@cyberelk.net>,
        linux-parport-owner@lists.infradead.org,
        linux-kernel@vger.kernel.org, helpdesk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
thank you for your information.

On our website you can find email addresses of companies and people.
https://www.skymem.info

In short, it=E2=80=99s like Google for emails.

Best regards,
Robert,
Skymem team

On Wed, Oct 12, 2022 at 10:57 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> On Wed, Oct 12, 2022 at 8:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > The linux-parport@lists.infradead.org mailing list is listed in
> > MAINTAINERS.  There's not much current activity [1], but I suspect
> > there's some useful history that we might want to preserve.
> >
> > Should we add linux-parport to the lore.kernel.org archives?
>
> It would be really great, if it is possible to have the list and the
> archive in lore.kernel.org
>
> --
> Regards
> Sudip
>
> _______________________________________________
> Linux-parport mailing list
> Linux-parport@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-parport
