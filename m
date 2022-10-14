Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20A45FEB6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJNJPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJNJPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:15:52 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F414E165537;
        Fri, 14 Oct 2022 02:15:48 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.20.52])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id D91F213086EE7;
        Fri, 14 Oct 2022 11:15:45 +0200 (CEST)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 14 Oct
 2022 11:15:45 +0200
Message-ID: <03489236-8645-340f-d101-6a23dd102076@traphandler.com>
Date:   Fri, 14 Oct 2022 11:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/6] leds: Add a multicolor LED driver to group
 monochromatic LEDs
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <lee.jones@linaro.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <johan+linaro@kernel.org>,
        <marijn.suijten@somainline.org>, <bjorn.andersson@linaro.org>,
        <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221007145641.3307075-1-jjhiblot@traphandler.com>
 <20221007145641.3307075-7-jjhiblot@traphandler.com>
 <CAHp75VcwcOqz_8yCYL09Nh7vqw5ZWOUR+1EJjpiNEz_tis-s+A@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAHp75VcwcOqz_8yCYL09Nh7vqw5ZWOUR+1EJjpiNEz_tis-s+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 2936909908230552027
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekvddgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepieejfedukeevudfghfetudevhffhhfekjeeiudegtdehueevgfdvgeeivdeifedvnecukfhppeduvdejrddtrddtrddupdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrnhguhidrshhhvghvtghhvghnkhhosehgmhgrihhlrdgtohhmpdhlvggvrdhjohhnvghssehlihhnrghrohdrohhrghdpphgrvhgvlhesuhgtfidrtgiipdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshhvvghnrdhstghhfigvrhhmvghrseguihhsrhhuphhtihhvvgdqthgvtghhnhholhhoghhivghsrdgtohhmpdhkrhiihihsiihtohhfrdhkohiilhhofihskhhiodgutheslhhinhgrrhhordhorh
 hgpdhjohhhrghnodhlihhnrghroheskhgvrhhnvghlrdhorhhgpdhmrghrihhjnhdrshhuihhjthgvnhesshhomhgrihhnlhhinhgvrdhorhhgpdgsjhhorhhnrdgrnhguvghrshhsohhnsehlihhnrghrohdrohhrghdpjhgrtggvkhdrrghnrghsiigvfihskhhisehgmhgrihhlrdgtohhmpdhlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhohedvkedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/10/2022 18:31, Andy Shevchenko wrote:
> But there is no compilation requirement for that.
> If you want to tell that this is functional requirement, you may use
>
>      depends on COMPILE_TEST || OF
>
> pattern
Yes. that is what I meant by adding depends on OF. Thanks.
>
> ...
>
>> +       struct device *dev = &pdev->dev;
>> +       struct led_init_data init_data = {};
>> +       struct led_classdev *cdev;
>> +       struct mc_subled *subled;
>> +       struct led_mcg_priv *priv;
