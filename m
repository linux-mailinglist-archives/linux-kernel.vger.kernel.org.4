Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67896BEDAD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjCQQFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjCQQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:05:26 -0400
Received: from 18.mo561.mail-out.ovh.net (18.mo561.mail-out.ovh.net [87.98.172.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8B60D41
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:04:57 -0700 (PDT)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.4.24])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id C26CE2668E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:04:53 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-ljxbb (unknown [10.110.171.111])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0C01B1FDF2;
        Fri, 17 Mar 2023 16:04:51 +0000 (UTC)
Received: from milecki.pl ([37.59.142.102])
        by ghost-submission-6684bf9d7b-ljxbb with ESMTPSA
        id pQNhOaOPFGR9LCYAwsBWZw
        (envelope-from <rafal@milecki.pl>); Fri, 17 Mar 2023 16:04:51 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-102R004ac1e6109-3b86-4a94-b551-02a4c2f0f22c,
                    EED6CEFD7F1E654E27D1F960EB8ACCFF2FD7B002) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Message-ID: <d7b026ea-036a-fd47-648f-b5b10ca58cea@milecki.pl>
Date:   Fri, 17 Mar 2023 17:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V4 4/4] nvmem: layouts: add fixed cells layout
To:     kernel test robot <lkp@intel.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230317132620.31142-5-zajec5@gmail.com>
 <202303172348.sb4rePWl-lkp@intel.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <202303172348.sb4rePWl-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10350679321734130651
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpefggefgjeefffekfeejffejhfektddvhfefleevgedvlefhtdeihfefudeijeeitdenucffohhmrghinhepghhithdqshgtmhdrtghomhdpghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghdptddurdhorhhgpdhgihhthhhusghushgvrhgtohhnthgvnhhtrdgtohhmnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.2023 16:54, kernel test robot wrote:
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20230317]
> [cannot apply to robh/for-next krzk-dt/for-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.3-rc2 v6.3-rc1 v6.2 v6.3-rc2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Rafa-Mi-ecki/dt-bindings-nvmem-layouts-add-fixed-layout/20230317-212948
> patch link:    https://lore.kernel.org/r/20230317132620.31142-5-zajec5%40gmail.com
> patch subject: [PATCH V4 4/4] nvmem: layouts: add fixed cells layout
> config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230317/202303172348.sb4rePWl-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/7ffae9ad6cdb83ae60e3eacf96ab779e0b69a65b
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Rafa-Mi-ecki/dt-bindings-nvmem-layouts-add-fixed-layout/20230317-212948
>          git checkout 7ffae9ad6cdb83ae60e3eacf96ab779e0b69a65b
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/nvmem/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303172348.sb4rePWl-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/nvmem/layouts/fixed.c:37:1: warning: data definition has no type or storage class
>        37 | module_nvmem_layout_driver(fixed_nvmem_layout);
>           | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/nvmem/layouts/fixed.c:37:1: error: type defaults to 'int' in declaration of 'module_nvmem_layout_driver' [-Werror=implicit-int]
>>> drivers/nvmem/layouts/fixed.c:37:1: warning: parameter names (without types) in function declaration
>     cc1: some warnings being treated as errors

I reported that to Miquel already, he's going to improve his patch:
https://lore.kernel.org/lkml/20230316173741.4f572068@xps-13/


> vim +37 drivers/nvmem/layouts/fixed.c
> 
>      36	
>    > 37	module_nvmem_layout_driver(fixed_nvmem_layout);
>      38	
> 
