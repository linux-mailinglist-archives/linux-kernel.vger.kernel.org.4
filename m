Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3387165CBF6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjADCmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjADCmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:42:02 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B74FD30;
        Tue,  3 Jan 2023 18:41:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ud5so79600926ejc.4;
        Tue, 03 Jan 2023 18:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DHAdUafUEa2Sx9gsnv6sHrzKEesKIKtSak3NT7xjZvM=;
        b=Dx0nsiXOVjITlpL5wzRH7dIyfnVZW+bdxeSusalAt/y3yH+93OI1ujP6b2Et7OsUqm
         WNhiZ+Spvg+/jiayzUHKDUG1Uc0luV9NIGcMK6R373nCtm0a+AT2UzGcLq7wl0OeetZG
         nvXy91dY0ELofYE/vJbItC38yrvEq2h0ZrJuWlbs65XuP+Z9A4n1/f7jPKZzOdPpkY+y
         ehWcHSFyKGM+7oH/xGjpLmvwiOXs9MbZdWK3jAuANBRP93kRXyv5MxwaViWUC9AtS6sL
         adbMZsNunZ0frBwVe1J95kzJaAj7ZpFGt0qW+ELEmWaNOaX3ALyocygce0h16vkKgdSS
         KfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHAdUafUEa2Sx9gsnv6sHrzKEesKIKtSak3NT7xjZvM=;
        b=fQjCPiZ10Fm3C6V+rBlteoQ0W4HjAh+jH9pYautie4EEnbD8/2l+CR25vQFayx2ARp
         p7qdgkQLTms3T8DuaTq7vsXesn+OF27S3Zi91HoSc7ljFj9XwzxSDaZzloYrXxTZCArV
         8KOiu83X6Kn6PqXMAE5QrhjWwXBx6I61AU7YJ7/Kjin23V9DrGz9LdHyumUwp9Buumzj
         onfhYBIET7r6hyGtyHgFmEtUDmLfJZYa2yKVvlvuCAIITnDLIT34FSA//goJIocVpcO2
         N4xj7t7YXSwvvXvKoZ7O4+NcO/2kBcZQ6f8Rl90uuGwCjSDpTT4WH/lUcDrNZgIEvv7i
         jZ0Q==
X-Gm-Message-State: AFqh2koWj9PFeN8lvl1QWQBFBxPEtmzIZ6CsL0Qjr8CSxQGkGbZprGP6
        WRhfV0kSlhVNGwfbBWP/ZNlpm+ZxsP9lO9JNEXw=
X-Google-Smtp-Source: AMrXdXt5ldvQNrNZWPrEm0KHPi/tqeW5PzLvOP2Ef71Jn4Ks7xwZUgRg3QfEheejpxCl8qAYERbcsuAhocIZuhu4O6E=
X-Received: by 2002:a17:906:6a04:b0:803:3f50:a7af with SMTP id
 qw4-20020a1709066a0400b008033f50a7afmr3037932ejc.78.1672800115444; Tue, 03
 Jan 2023 18:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20230104021445.47484-1-quic_bqiang@quicinc.com>
In-Reply-To: <20230104021445.47484-1-quic_bqiang@quicinc.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Tue, 3 Jan 2023 19:41:44 -0700
Message-ID: <CAOCk7NpGBD-2nHFBE3a4WxNb4XPhEV3uoCDz1J9ArbaOE7Vscg@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: host: Change the log levels for SYS_ERR event
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
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

Why was this not sent to the MHI mailing list?

On Tue, Jan 3, 2023 at 7:19 PM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>
> Currently no log printed when SYS_ERR happens, this makes
> debug quite hard, so change log level to make it noisy.

You are going to need to explain this more.
There are two drivers in the upstream kernel that are MHI clients -
pci_generic and ath11k.
I'm assuming that you care about ath11k because you included that mail list.
In ath11k_mhi_op_status_cb() I see a warning message printed when the
syserr callback is triggered.
I see something similar in pci_generic.

Looks like a log is printed when SYS_ERR happens in all possible
scenarios, so I don't understand the point of this change.
Particularly given that dev_dbg messages can be trivially enabled.

-Jeff
