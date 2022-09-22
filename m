Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F1B5E61BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiIVLxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIVLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:53:12 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46310979D5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:53:10 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220922115306euoutp0208a8805a3fc9944b34aa6b2854ebb219~XLJCSeW4q2996029960euoutp02B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:53:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220922115306euoutp0208a8805a3fc9944b34aa6b2854ebb219~XLJCSeW4q2996029960euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663847586;
        bh=u8B68iZhHsDKI4cIzdR1Y2hA5mMXV8Cld2Sk7jmlWk0=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=GGfQ+LOknSn0FJRueSi/uArudKYhwLBS5aQ05zQUNJ+UXQUFRlfR9DbebpYkmuZ6X
         dAmDbAloaAetKC3XqVODZ/AuND/Va5ocpgSv6LiNNvm/YIxGhM5EqfCPmxWpxYkQ3C
         NdR0lG9bAug493tvSzo+m4Wsk1viji2ZrfRbxETY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220922115306eucas1p12b7db3f20df086bdff2ff3400cd52ca1~XLJB7_SLs2018120181eucas1p1Y;
        Thu, 22 Sep 2022 11:53:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.89.07817.2AC4C236; Thu, 22
        Sep 2022 12:53:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220922115305eucas1p1b862ce6603248112d2b0836f37f922f2~XLJBZmEFt3156431564eucas1p1O;
        Thu, 22 Sep 2022 11:53:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220922115305eusmtrp15dccd4d9687bb0f6a554d7a41d80da06~XLJBYjnIZ2733027330eusmtrp1l;
        Thu, 22 Sep 2022 11:53:05 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-3b-632c4ca25f3a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.97.07473.1AC4C236; Thu, 22
        Sep 2022 12:53:05 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220922115305eusmtip2f92eefce3c8f8d5f30b16cc3aebb9e87~XLJBOExt23183331833eusmtip2e;
        Thu, 22 Sep 2022 11:53:05 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.168) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 22 Sep 2022 12:53:03 +0100
Message-ID: <b393c127-b773-8296-a559-83606077aa1c@samsung.com>
Date:   Thu, 22 Sep 2022 13:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was:
 Re: [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone
 sizes]
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mike Snitzer <snitzer@redhat.com>, <axboe@kernel.dk>,
        <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     <agk@redhat.com>, <snitzer@kernel.org>, <bvanassche@acm.org>,
        <pankydev8@gmail.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <Johannes.Thumshirn@wdc.com>, <jaegeuk@kernel.org>,
        <matias.bjorling@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.168]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87qLfHSSDfY2CVusP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBYrVx9lsniyfhazxd+ue0wWkw5dY7TYe0vb4vKuOWwW85c9ZbeY
        0PaV2WLNzacsFiduSVu0bfzK6CDgcfmKt8fOWXfZPS6fLfXYtKqTzWPzknqP3Tcb2Dx2tt5n
        9Xi/7yqbx+dNch7tB7qZAriiuGxSUnMyy1KL9O0SuDJuf/nHUtDCV/Fk2wuWBsap3F2MnBwS
        AiYSf1Z/Z+li5OIQEljBKNHZcYoRwvnCKHHz1Cc2COczo8SSJZ1sMC0XmrcyQySWM0pM/NTB
        Dle1c8ZvJghnN6PEgwO/WUBaeAXsJP7vmc0KYrMIqEo8mnGTGSIuKHFy5hOwGlGBSIk1u8+C
        TRIWmM8oca39IFiCWUBc4taT+WBTRQTmMUrMuneQFSJxgEli3iu/LkYODjYBLYnGTnaQMKeA
        m8S8Z/vYIEo0JVq3/2aHsOUltr+dwwzxg7LE8tMzoexaibXHzoAtlhB4xilx6+caqISLxLmT
        75kgbGGJV8e3sEPYMhKnJ/ewQNjVEk9v/GaGaG5hlOjfuZ4N5CAJAWuJvjM5EDWOEg/fLmGG
        CPNJ3HgrCHEPn8SkbdOZJzCqzkIKi1lIXp6F5IVZSF5YwMiyilE8tbQ4Nz212CgvtVyvODG3
        uDQvXS85P3cTIzAdnv53/MsOxuWvPuodYmTiYDzEKMHBrCTCO/uOZrIQb0piZVVqUX58UWlO
        avEhRmkOFiVxXrYZWslCAumJJanZqakFqUUwWSYOTqkGpt2TX++Q91p1WeVcXLx4krnXYlOx
        5SJe0zbWN2krM4ebNekwmq8RzFtzWOTOom/uPUc/yirLfE2/avolekKf9roW7cc2EQtbJ/NG
        MKtOEtr0Y3vI/+TlYXUT/3r/smQTaXvMtYerf83xadWPlEo2J2Z1ZSpanLbZ8kumdIcCC2Nj
        jYWD6vvol2lSk67OuHXsfeyN8K/GEx9fmeliw2Iau2jiHaO7N56Gzt+1+eeDc/+iVQ97rHYI
        qXKtSp3wbIW1/dZN9+sW/RKzrrJdOemgTOD5Cu9VfYFT3My9fol8WNQrIHpD02HXIrkwxbup
        i0M+cO7N5So19Tnu2HhgwUKve01/JMN0Djo1up1k+ak+VYmlOCPRUIu5qDgRAPO4N0/2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xe7oLfXSSDXbv0rVYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1Wrj7KZPFk/Sxmi79d95gsJh26xmix95a2xeVdc9gs5i97ym4x
        oe0rs8Wam09ZLE7ckrZo2/iV0UHA4/IVb4+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHnsbL3P
        6vF+31U2j8+b5DzaD3QzBXBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GXc/vKPpaCFr+LJthcsDYxTubsYOTkkBEwkLjRvZe5i5OIQEljKKLGw
        6yELREJG4tOVj+wQtrDEn2tdbBBFHxklHny+zwLh7GaUWHPxHytIFa+AncT/PbPBbBYBVYlH
        M24yQ8QFJU7OfAI2VVQgUuLhsiYmkGZhgbmMEoe+LAJLMAuIS9x6Mh8sISIwj1Fi1r2DrCAO
        s8A+JokrX89CXfiCUeLJ20+MXYwcHGwCWhKNnWAHcgq4Scx7to8NYpKmROv23+wQtrzE9rdz
        mCGeUJZYfnomlF0r8er+bsYJjKKzkFw4C8khs5CMmoVk1AJGllWMIqmlxbnpucWGesWJucWl
        eel6yfm5mxiBaWTbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd7ZdzSThXhTEiurUovy44tKc1KL
        DzGaAoNpIrOUaHI+MJHllcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFw
        SjUwGe5TfJyhXjxpTY3dJHXF2NJIw/Ds8uNrnXhF/PjmLDTNyK0rNXl5lS3k5sopU193fDAo
        dJ7VJyCc66K6YjaD/Pktd56ESaq9nZmt+fDZEslH6V+iO2QnfzGf7jpB5cZ7U9GMW5Unfk7d
        vZpxt8Eu1XUrD/331Mmr83Bl6JMouDt30aHymbfFs0r/Pos4r6xyxU0/ZVP+ojPMZ51PcmsU
        Xt7ddzh1VsPFrIdReusPP1qkqPFE9uHMNQJmh+xlWwPc53Nczpm5urtfIzJr4WH3Y5GhBxfU
        spd0rct/3jDHi1kgtZ1t9hY/Rb8b73MFpXb9aipNWeYh53thU5bqVDPDFYpqJgee7Z7iJqj6
        5IasEktxRqKhFnNRcSIAtXBZ3qwDAAA=
X-CMS-MailID: 20220922115305eucas1p1b862ce6603248112d2b0836f37f922f2
X-Msg-Generator: CA
X-RootMTR: 20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
        <20220920091119.115879-1-p.raghav@samsung.com> <YytJhEywBhqcr7MX@redhat.com>
        <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot Damien for the summary. Your feedback has made this series
much better.

> Pankaj patch series is all about supporting ZNS devices that have a zone
> size that is not a power of 2 number of LBAs as some vendors want to
> produce such drives. There is no such move happening in the SMR world as
> all users are happy with the current zone sizes which match the kernel
> support (which currently requires power-of-2 number of LBAs for the zone
> size).
> 
> I do not think we have yet reached a consensus on if we really want to
> accept any zone size for zoned storage. I personally am not a big fan of
> removing the existing constraint as that makes the code somewhat heavier
> (multiplication & divisions instead of bit shifts) without introducing any
> benefit to the user that I can see (or agree with). And there is also a
> risk of forcing onto the users to redesign/change their code to support
> different devices in the same system. That is never nice to fragment
> support like this for the same device class. This is why several people,
> including me, requested something like dm-po2zoned, to avoid breaking user
> applications if non-power-of-2 zone size drives support is merged. Better
> than nothing for sure, but not ideal either. That is only my opinion.
> There are different opinions out there.

I appreciate that you have explained the different perspectives. We have
covered this written and orally, and it seems to me that we have a good
coverage of the arguments in the list.

At this point, I would like to ask the opinion of Jens, Christoph and
Keith. Do you think we are missing anything in the series? Can this be
queued up for 6.1 (after I send the next version with a minor fix suggested
by Mike)?

--
Regards,
Pankaj
