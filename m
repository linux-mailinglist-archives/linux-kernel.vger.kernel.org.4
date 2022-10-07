Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F09E5F7B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJGQiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiJGQiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:38:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE55A92F4C;
        Fri,  7 Oct 2022 09:38:04 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5CA5E5C0174;
        Fri,  7 Oct 2022 12:38:02 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Fri, 07 Oct 2022 12:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1665160682; x=
        1665247082; bh=Wut//gW95b9YmcBiYNJlr5pIpVRvIt/e3uD4ITntccQ=; b=G
        J3iB0FOXvPugesXlHFTOcqWpq+EWsf+VOkkgpJ+c6W7u9+HjtbkuX51wGSLOcabo
        Oe0GppyiYC3T+Pj81Sdx1mEFNqN2ynIdti/lKzodRfJ3mXLQE9nkN/TK5imxWNBv
        c62+spI4OnYTjk3Xkl2hImhD2kvnwgu62bdFrtv8f1jLx+jBVu3ke6HJxRFTdlWI
        SqnpFHnHWUNHdBFTIpb6wATm0P1T4lJ1RSd73GmA23R61GBZCuggND/A5L3yPQ8Z
        c+pheUNe7d+89Onlt7mSEURUwAbN/RggYXg0KQmQcZyfHmGiEfymQZIOEYYlO3QQ
        MZHzrMBe/Zvw4vtdjLeFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665160682; x=
        1665247082; bh=Wut//gW95b9YmcBiYNJlr5pIpVRvIt/e3uD4ITntccQ=; b=n
        J/LQywBfy6PIDq7MuDo1LW6TYLjEPgpxBnRiCJepoCg4vw9IQXt8maO/K6l9FDrd
        XGRkFF6ad118I69bakhx5FBumyI7+IXq8to5cySlSipD0nWO5kcuVHWfwSWOG1o/
        f/3FeBFQmNeUWF1Ap3nDSzqNQzuc0VUFE+Ce/Pkj1Q91LGVKrXjEP+xoyjJoeSIB
        puh1plNYQzz9whWELNbIC1ycfgB0D0QFynD9+cVTbPtv0zOYgeG7oKyvv+aiodrv
        zcOctKt/eiFrbthi1ZPwjvciQiU+vNVyc3UgsMLHRzrbSaU3rZIlwHnilQflz7Fm
        d3Tz9T6bRVM+LDYhX2aPA==
X-ME-Sender: <xms:6VVAY_O49uKDDJLOcuIQ4f5boSXt8fH55zjSj_oBeYE3B5yhOJTsHw>
    <xme:6VVAY58tMc_fCuKVmkNcsNw7Z8QfQhQxExTZ6XiOl_jrU-YdRnil_7mWaKrrYm_y6
    I_zpuuJ_tNxGwb-Rbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homheqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefh
    jeeugeevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:6VVAY-Se4U65sn7GJzCjrP9kMkT5m1hGvHGa9e8cHyMRZnDbjfGNlw>
    <xmx:6VVAYzvr5MHIfJupyaRLOh0uQjgPOtxl8PXpCXZoPfs0AGR9ZTnpOQ>
    <xmx:6VVAY3fudnrWARaVpMR_mTbrj0VsjnbSBE3Y4OK_x67IzvSkIQmWyQ>
    <xmx:6lVAYz53p1Y4m4rh7OeRhSXgPXNVqJLqHRmLu9sPyVjkk7EicgoVSw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C9C5436A0073; Fri,  7 Oct 2022 12:38:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <b3886864-5c54-4524-8e30-b6701553b615@app.fastmail.com>
In-Reply-To: <Y0A9L2KajswAEKsu@kroah.com>
References: <20221007141207.30635-1-jiaxun.yang@flygoat.com>
 <Y0A9L2KajswAEKsu@kroah.com>
Date:   Fri, 07 Oct 2022 17:37:34 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Greg KH" <greg@kroah.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-api@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH v5] MIPS: Expose prid and globalnumber to sysfs
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B410=E6=9C=887=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=E5=
=8D=883:52=EF=BC=8CGreg KH=E5=86=99=E9=81=93=EF=BC=9A
[...]
>> +
>> +static int cpuregs_cpu_offline(unsigned int cpu)
>> +{
>> +	struct device *dev;
>> +	struct cpureg *reg =3D per_cpu(cpuregs, cpu);
>> +
>> +	dev =3D get_cpu_device(cpu);
>> +	if (!dev || !reg)
>> +		return -ENODEV;
>> +	if (reg->kobj.parent) {
>
> Why are you looking at the parent of a kobject?  Why not just always
> remove the kobject if you have a reference to it now?  How does the
> parent matter?

Another dummy copy from Arm64 code... kobject_put should be enough here?

Thanks

>
> thanks,
>
> greg k-h

--=20
- Jiaxun
