Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9DC70458F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjEPGvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjEPGvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:51:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1FB44AB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 454FB623A9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A66C433D2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219856;
        bh=OVP/rerETkXsjJ0I6Oo86srhf+okaQ4WPHGI2BJ0adU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cX0gUuIWjuMYOeF8xYopDOXyaLqObrvjwvfDoNS3Zd/QpCrSheAGqFQR4KtRpv0Ga
         8EP1ivUqUtGAisYjKu/NX7BIzLQI9GceJrzQ9pA6OwvbeWRsfWfkh/GaD/jir/TFD+
         QWakD3Gst/TFIJ4rE5QLubI9QNTLNfdhluMzhSY3wYVxKnAZbVEyDF/izaZbkmcWEX
         XCQC0TTztcuz+qQf8blIe95/AjaTI1q7xuujtxK6LvZF+ba7aUWP0496qJM7+TM/Hy
         vsfnFk784nN64prOcWzmdRO/yBJqiXhl4M7VyTjZvZ+bji6FzELiqL24cABMmmUZ0c
         4cYLvZdPpwCUA==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-55a2cb9788dso194558787b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:50:56 -0700 (PDT)
X-Gm-Message-State: AC+VfDxVEjYLpIH5tnUlLL2/UpLzIemxaE+8IkTGW5onjSiFZpcImOWL
        6nReXgYArAc8lToUyK2TUX3hmPmHdUj//D1h+hM=
X-Google-Smtp-Source: ACHHUZ797wJH62FhSxc0l09+6zJ+7Djyy3aB4kp9B63Ei2gpKIZqgZUgw3jpLrG2e+qYrge+r721aglIYLNutMGush8=
X-Received: by 2002:a81:52d0:0:b0:55a:20d5:e103 with SMTP id
 g199-20020a8152d0000000b0055a20d5e103mr33500157ywb.34.1684219855580; Mon, 15
 May 2023 23:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230512064655.82246-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230512064655.82246-1-yang.lee@linux.alibaba.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 16 May 2023 09:50:28 +0300
X-Gmail-Original-Message-ID: <CAFCwf139EwbAnhf4RJXxLmxPA4gZGjrMNCJv55muncBMMp8BAA@mail.gmail.com>
Message-ID: <CAFCwf139EwbAnhf4RJXxLmxPA4gZGjrMNCJv55muncBMMp8BAA@mail.gmail.com>
Subject: Re: [PATCH -next] habanalabs: Fix some kernel-doc comments
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 9:47=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> Make the description of @regs_range_array and @regs_range_array_size
> to @user_regs_range_array and @user_regs_range_array_size  to silence
> the warnings:
>
> drivers/accel/habanalabs/common/security.c:506: warning: Function paramet=
er or member 'user_regs_range_array' not described in 'hl_init_pb_ranges_si=
ngle_dcore'
> drivers/accel/habanalabs/common/security.c:506: warning: Function paramet=
er or member 'user_regs_range_array_size' not described in 'hl_init_pb_rang=
es_single_dcore'
> drivers/accel/habanalabs/common/security.c:506: warning: Excess function =
parameter 'regs_range_array' description in 'hl_init_pb_ranges_single_dcore=
'
> drivers/accel/habanalabs/common/security.c:506: warning: Excess function =
parameter 'regs_range_array_size' description in 'hl_init_pb_ranges_single_=
dcore'
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4940
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/accel/habanalabs/common/security.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/habanalabs/common/security.c b/drivers/accel/h=
abanalabs/common/security.c
> index 297e6e44fd0c..dc23ff57c91a 100644
> --- a/drivers/accel/habanalabs/common/security.c
> +++ b/drivers/accel/habanalabs/common/security.c
> @@ -495,8 +495,8 @@ int hl_init_pb_single_dcore(struct hl_device *hdev, u=
32 dcore_offset,
>   * @instance_offset: offset between instances
>   * @pb_blocks: blocks array
>   * @blocks_array_size: blocks array size
> - * @regs_range_array: register range array
> - * @regs_range_array_size: register range array size
> + * @user_regs_range_array: register range array
> + * @user_regs_range_array_size: register range array size
>   *
>   */
>  int hl_init_pb_ranges_single_dcore(struct hl_device *hdev, u32 dcore_off=
set,
> --
> 2.20.1.7.g153144c
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
