Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1328B60325A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJRSYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJRSXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:23:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8435D895C5;
        Tue, 18 Oct 2022 11:23:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w18so34348051ejq.11;
        Tue, 18 Oct 2022 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZBPHoNZKlTPkMVXlpehGWAtf/+k0whAcSa7J8RtYY8k=;
        b=JxGDJ7fvYKVMIiMcswt0O70UsE0asYpg87o7T+qtr6Ez/hhKLKjly5AGwn871+Sc7O
         nfMt8KN9/+D/e8O0cwZxUztEVsVoG8NH5ewwL6wMQ8cp18Lp8imG1jkazIiKjKOLzClp
         SPKKd69sGyoMHiicOWUhZ/MweofloX6snGEbz6uDlx+pXWuHod5d3jyQyeSvpYLu9yJG
         tpXB6ziiHqoDjox2ctZQ+BAYBHNWpwR+H3rSYKS6Uu1L/H9Cp0ngys/dWRTEmtdHUeYH
         l3i0U4qNsIGfKM76M+PzB4ut7q1s5E23eLEFel26jewbCPcdq9EMCad19tIzkFT//Vpc
         6C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBPHoNZKlTPkMVXlpehGWAtf/+k0whAcSa7J8RtYY8k=;
        b=wpN6YWWg3NDCb8YAxz+lRuixVzubh5rJReyiZBKiR/sEZZxFwsPygxpTW37lBXeIve
         g1f5F/MyFL5ux9dGev+PH4H8joECU7+DybZrBVGBuf6DVjbRBV6hy3CJuc79Q4nCGoiH
         RcFzvuWF9GM/HhSBv/qyrV66okiCcW/hK6DxGX92r66HYtPb/nehUUde5e/AX0yO6qBW
         j5Fzdc7jpdklV99B5WFAfT4hFeWteXoLyw4z4CQ/MhorDMIQladj6+frSH9x8C6Fqh4+
         5xKdncpuD3OkFREpIqJ/8wDQOMJ6y8zMlP+bA20aTPXMzKQXq6FNxBeCnFFAAW7C4OKP
         pTdw==
X-Gm-Message-State: ACrzQf2oTYFSiXAk9dZOkPUHBf3UJ8NS1Q4GUODDv3s7qdgRkPNyNmKK
        bK0i2WpLtjqwMDQ2zi+oGCI=
X-Google-Smtp-Source: AMsMyM6iPe/jWpjB05uCFxphLJ+sWIhDcXUj0kEI1C8FRrwuhqgAoDh8bqHb7BfZIlJv3llD348Y+Q==
X-Received: by 2002:a17:907:d02:b0:78d:b3cd:a277 with SMTP id gn2-20020a1709070d0200b0078db3cda277mr3507624ejc.622.1666117416081;
        Tue, 18 Oct 2022 11:23:36 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id g7-20020a170906538700b00782539a02absm7966855ejo.194.2022.10.18.11.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:23:35 -0700 (PDT)
Message-ID: <7504ebe7163c1aeb14fb52914a51d603ec0ff796.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] scsi: ufs: core: Remove unnecessary if statement
From:   Bean Huo <huobean@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Oct 2022 20:23:34 +0200
In-Reply-To: <8fbe22f1-d216-3841-62c3-675dcb8b6e8d@acm.org>
References: <20221018181627.326657-1-beanhuo@iokpp.de>
         <20221018181627.326657-2-beanhuo@iokpp.de>
         <8fbe22f1-d216-3841-62c3-675dcb8b6e8d@acm.org>
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

On Tue, 2022-10-18 at 11:20 -0700, Bart Van Assche wrote:
> On 10/18/22 11:16, Bean Huo wrote:
> > From: Bean Huo <beanhuo@micron.com>
> >=20
> > LUs with WB potential support are properly checked in
> > ufshcd_wb_probe()
> > before calling ufshcd_read_unit_desc_param(), so remove this
> > unnecessary
> > if-checkup in ufs_is_valid_unit_desc_lun() to match its function
> > definition.
>=20
> Hi Bean,
>=20
> Does this patch differ from a revert of Jaegeuk's patch? If not,
> please=20
> change the patch title into "Revert scsi: ufs: WB is only available
> on=20
> LUN #0 to #7" and add "Cc: Jaegeuk Kim <jaegeuk@kernel.org>" just
> above=20
> the Signed-off-by line.
>=20
> Thanks,
>=20
> Bart.

Bart,=20

no difference, I will change its title and CC Jaegeuk.

thanks,
Bean
