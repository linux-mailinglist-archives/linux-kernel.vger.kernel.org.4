Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E695FF4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJNU5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJNU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:57:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0031C493A;
        Fri, 14 Oct 2022 13:57:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fy4so12991269ejc.5;
        Fri, 14 Oct 2022 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gTPmzPxOnY51QoZSyHNdoQWICRe1EvMKuBtV8mL2WRk=;
        b=Rq81klq9oTpXEBBWyMNDfG0ST2gxY3NXqahkyIdk00VLzheWDxTeNU9H3I7mh0I8Z5
         YdditzDGZSdpJbPTDFRtca9Bvxdt10LNDEI4sTIy/tQFZFaVMm3PXrMp7pL+ySvijDWa
         cxVsH9XsOsGMAXYlf4djn0pZH+DanJt8Y+Izue3V/F/SQn/hg276bQdJU0WK0SoJlWQV
         Isy0wMErCkOBB5zyXx5EYNXlBbPl6tZslV2wlD8//6TfI+o25VArgYBAmHbM1ChYtc5s
         CvTUjQ0wBahU4W2C7lW6jxqYaI2Lep3b8niCtNwlOhhOLAejvtGwxG2SmkOqQMocsR9u
         fBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTPmzPxOnY51QoZSyHNdoQWICRe1EvMKuBtV8mL2WRk=;
        b=GPhQGF31ZhK4wejzk7hmkDwVqYlGP33akcOAFg/lKfKy9fvA4R+q+VND2LZyPaNO+I
         w0wjJcwNQ2YOJeK9GIJt7NIhdxVtBGiwOXSvU5qxOZXyDJT5LSXzD0mbCM+8GCUH6NPY
         7HxwB+VehLsuXhLCLf1uIZ3okICkZI0TbPQy+Pko+HRD5OJEDTrxTW5FensecrvsL7Xo
         +EqVufaTOQDRHAdNbOgf3R1T28eIDudiq7apRV0dWcvsYNQczcFMc+DxZMguYFRcHKIb
         sGmUNb4tY9OBD7ovc0bM19422ivWs9zSIEA+vjaSic2mJ944984i69zAtKMq7Ec/p3uX
         bfJA==
X-Gm-Message-State: ACrzQf2uw1QL82i5KmC1JDV5yN7wZlqRitiLi7E3wynNXpclLfhk1A1Y
        +h9waoZYu7G2YCKt0LP0E8U=
X-Google-Smtp-Source: AMsMyM6aVPeke+Oypo2/VWrATxyqTprNVBWBBdzKUjApbtJmtOWUuouDnbxqNovrwKeWC+LCSg2JtA==
X-Received: by 2002:a17:906:4795:b0:787:434f:d761 with SMTP id cw21-20020a170906479500b00787434fd761mr4858277ejc.597.1665781038088;
        Fri, 14 Oct 2022 13:57:18 -0700 (PDT)
Received: from [192.168.3.3] (p4fd591a2.dip0.t-ipconnect.de. [79.213.145.162])
        by smtp.googlemail.com with ESMTPSA id p4-20020a056402074400b0045bccd8ab83sm2468909edy.1.2022.10.14.13.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:57:17 -0700 (PDT)
Message-ID: <710292d355b7b0872f178206468769a859755ce4.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] scsi: ufs: core: Remove unnecessary if statement
From:   Bean Huo <huobean@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 14 Oct 2022 22:57:17 +0200
In-Reply-To: <ffc4250d-7446-40eb-9218-6925f44a69ff@acm.org>
References: <20221010092937.520013-1-beanhuo@iokpp.de>
         <20221010092937.520013-2-beanhuo@iokpp.de>
         <a1cd6719-a743-fc96-e0e7-364a52b62952@acm.org>
         <d06a264c4544a23ccccd016c6797d889db526b64.camel@iokpp.de>
         <ffc4250d-7446-40eb-9218-6925f44a69ff@acm.org>
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

On Fri, 2022-10-14 at 13:41 -0700, Bart Van Assche wrote:
> On 10/14/22 12:20, Bean Huo wrote:
> > I am working on the Advanced RPMB, and trying to seperate normal
> > unit
> > descriptor and RPMB unit descriptor, will let you know if it is
> > possible. or if you know the solution, please let me know, thanks.
>=20
> Hi Bean,
>=20
> How about setting .is_visible member of struct attribute_group in the
> UFS
> driver and letting that callback decide which sysfs attributes are
> visible
> depending on the logical unit type?
>=20
> Thanks,
>=20
> Bart.

Thanks, it looks like what I expected, I'll verify it further.

Kind regards,
Bean
