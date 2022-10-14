Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A305FF495
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiJNUbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiJNUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:31:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0717074;
        Fri, 14 Oct 2022 13:30:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m15so8309436edb.13;
        Fri, 14 Oct 2022 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SeHanmAEnbS/igdFCXsAS08y1aN5+fY+hKTXSkNcZJc=;
        b=UrVLZXxQVLSsmEC846qmn32XR6eHfHYMkEAu1hhhWZ36ah6QB8Oa+5y/mC4CGzAh/I
         Ao3FmAGsI/UTh/6gNipqc3U2HNTehLtZwJu6GGAJP8KJa3IOVVnF8A8JDPGaZP6XBsx1
         BW+Rp/THefCKglNkpvaAsVgTijdJmnhcm7t/ozPRk29GOfKv4tKyhNUicn0CwbZrcUe1
         UbSSGddSczk6299lU9x/9HSQ7WgFIO5lJ8OItZulrwbz01csOMxIhSj2J8hhF1Axstnz
         I1sgfk6rxN9RHkAqgcAmq7Fnl/oX3L+kJYeLtbF1cOdJ6bT1FDLbX+q5JC1fG5zcWvp4
         nxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeHanmAEnbS/igdFCXsAS08y1aN5+fY+hKTXSkNcZJc=;
        b=VtV5ycUV0HuqZTLj9LISzrRFqBIlJCCciMc4wc6pwHK7qcPmVqDrVyuHNO1QQvW8Wo
         LMGI3IPg7ojvBkLo8orQQGkfwozLJjoSVwuLuu5HACbXELuwquoVSFNCIvwPJOkQiRmO
         i70dfbGszVxmx3S53ba6uRVUII/BJYPnc3OfHRLMAs2XBCGHwRv8/boTD7/+Kq92HG9u
         jaV+g/xE7y8MpdJF3B3ZV4hrkGrfco3QS4AMtH/V6PRVmKdmReabWMsjpxe8Zbj0CteJ
         ZSJUHwrX6ISyIZ6vKJMpRsLTeqyfHZg1jRNYQwK2AVtQtQ3gyHs22UAnjC7h670AjUa8
         kPcg==
X-Gm-Message-State: ACrzQf0BFZkOgr5zwbVPywKMJwC7yFxGaHbIi44Io5KwuH9Quud4Urm1
        tfUfCoLuo0rjW8h6Q+DeXRc=
X-Google-Smtp-Source: AMsMyM44QFiF5pV5rrf1/fnUb9Xe4ofBqaAyprdjD6kpB+qxSgbHZkO//K2qtzqiAxPFk+ELQA8Mzw==
X-Received: by 2002:a05:6402:2489:b0:454:11de:7698 with SMTP id q9-20020a056402248900b0045411de7698mr5832069eda.214.1665779449954;
        Fri, 14 Oct 2022 13:30:49 -0700 (PDT)
Received: from [192.168.3.3] (p4fd591a2.dip0.t-ipconnect.de. [79.213.145.162])
        by smtp.googlemail.com with ESMTPSA id p5-20020a170906498500b0078b83968ad4sm2065437eju.24.2022.10.14.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:30:49 -0700 (PDT)
Message-ID: <227f117ee9491cc9d2ae4bb2211a99ccd1dd3c21.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] scsi: ufs: core: Remove unnecessary if statement
From:   Bean Huo <huobean@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 14 Oct 2022 22:30:48 +0200
In-Reply-To: <a1cd6719-a743-fc96-e0e7-364a52b62952@acm.org>
References: <20221010092937.520013-1-beanhuo@iokpp.de>
         <20221010092937.520013-2-beanhuo@iokpp.de>
         <a1cd6719-a743-fc96-e0e7-364a52b62952@acm.org>
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

On Fri, 2022-10-14 at 11:37 -0700, Bart Van Assche wrote:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err("Max General LU supported by UFS isn't
> > initialized\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* WB is available only for =
the logical unit from 0 to 7 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (param_offset =3D=3D UNIT=
_DESC_PARAM_WB_BUF_ALLOC_UNITS)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return lun < UFS_UPIU_MAX_WB_LUN_ID;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return lun =3D=3D UFS_U=
PIU_RPMB_WLUN || (lun < dev_info-
> > >max_lu_supported);
> > =C2=A0=C2=A0 }
>=20
> Hi Bean,
>=20
> I think the above patch reintroduces the stack overflow issue fixed
> by
> commit a2fca52ee640 ("scsi: ufs: WB is only available on LUN #0 to
> #7").
>=20
> How about reverting commit a2fca52ee640 and fixing the stack overflow
> issue in another way than by modifying ufs_is_valid_unit_desc_lun()?
>=20
> Thanks,
>=20
> Bart.

Hi Bart,=20

I double-checked the changelog and the stack overflow issue was double
fixed by your commit:

commit d3d9c4570285 ("scsi: ufs: Fix memory corruption by
ufshcd_read_desc_param()"),


For example, if the user wants to read wb_buf_alloc_units in the RPMB
unit descriptor,

parameter offset =3D 41, parameter size =3D 4,
buff_len =3D 45;

After ufshcd_query_descriptor_retry(), buff_len will be updated to 35.

param_offset > buff_len, then -EINVAL will be returned.

So we can safely remove this check, and if you still have concerns, I
can verify when I get back to the office.

Kind regards,
Bean
