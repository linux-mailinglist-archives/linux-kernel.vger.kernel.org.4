Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA599622356
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKIFIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKIFIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:08:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6120D18E27;
        Tue,  8 Nov 2022 21:08:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bs21so24067125wrb.4;
        Tue, 08 Nov 2022 21:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3jmOsDYD3eDGL/HXAFuu3q5wn5DTfdd7ABqci8j+7Y=;
        b=B8PJ9mjrG1f6p+hcfIm1hl3TORjKvJrBgzgSzoWH0E/sTqBNSgCEFnPDl1Zyf3OSet
         Fdz7067cjgBDhn9eBmrB4yGHWF2yCUeXNA6TfYtRcGBcerdDMZ6HOGLl/W/KAGa84Keg
         C56rxiNLaSbFwNpMomPnVm3urdSNb+t9vQFXesyPMFiEi11D7WA4aTqpBVyKV9FB4Sui
         Pqp3VO93yyUwiM4BxICHT4d1P59Z0RS1zYkQ+VlKbDyubn0/JbAMrtoSzbTYTfJw9ZJ4
         1KpMjHuWsIlgJULBFoAjRwZDMu7EFMmHYq62IUecXdHkI+vZh9TCU0dEN9pIeHBOt9Et
         KHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3jmOsDYD3eDGL/HXAFuu3q5wn5DTfdd7ABqci8j+7Y=;
        b=WnCebYEoB+78m09DScjpM0pQCcqT/vrTt0ceMWCAEqZuwoNoOI4GdYgniH4zCHVZjr
         E5lt7S5vXrWyucmP/0aZOa0fPkVgD14jqULOcR6jtj1QHMnoZZvqEadjCGsZL5d72PiA
         rCu8fAwpW55UOQmsn6utx8J/HhoFfWwJLw+rzq2vx0gAnBa7p9N9QhK3rYuwyrO1OfKt
         H8XIh7YZmbqBtwoi9RMIQtqk5hRV2Oc/1XdlnIxIsKd6kRMRYk6UH+Zhv0VRkkYG5tCo
         H0lc1Cvt3sjhGclpILTyZXgx8RAD4ko6l3Moc3bpJrQm/BycPjlX0Hvo3HSsV0K91dYz
         USOw==
X-Gm-Message-State: ACrzQf3UYdY7f3gyj7Xa+yTdT04qADEzjboDAvnkb1MBpRShesklVTKZ
        4BQ6QOtRnmCwSjzhzHePfuA=
X-Google-Smtp-Source: AMsMyM6IhiQGc9h4+6b5XsGBvBAxgexMWtYjzt9k9qAu3tpLlIDLGnz5Uu5ITn/T7WlkbKlaPzsyNw==
X-Received: by 2002:adf:b353:0:b0:236:5814:f4dc with SMTP id k19-20020adfb353000000b002365814f4dcmr35860498wrd.189.1667970515291;
        Tue, 08 Nov 2022 21:08:35 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600010c900b002368424f89esm12041478wrx.67.2022.11.08.21.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 21:08:34 -0800 (PST)
Date:   Wed, 9 Nov 2022 08:08:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Wenchao Hao <haowenchao@huawei.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        Wenchao Hao <haowenchao@huawei.com>
Subject: Re: [PATCH v6] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Message-ID: <202211090606.r22uKz8I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108014414.3510940-1-haowenchao@huawei.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenchao,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenchao-Hao/scsi-iscsi-Fix-multiple-iscsi-session-unbind-event-sent-to-userspace/20221107-202840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20221108014414.3510940-1-haowenchao%40huawei.com
patch subject: [PATCH v6] scsi:iscsi: Fix multiple iscsi session unbind event sent to userspace
config: m68k-randconfig-m031-20221108
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/scsi/scsi_transport_iscsi.c:1691 iscsi_session_target_state_name() error: buffer overflow 'iscsi_session_target_state_names' 4 <= 4

vim +/iscsi_session_target_state_names +1691 drivers/scsi/scsi_transport_iscsi.c

3aa534a2c8b080 Wenchao Hao 2022-11-07  1686  static const char *iscsi_session_target_state_name(int state)
3aa534a2c8b080 Wenchao Hao 2022-11-07  1687  {
3aa534a2c8b080 Wenchao Hao 2022-11-07  1688  	if (state > ISCSI_SESSION_TARGET_MAX)

Should be >=

3aa534a2c8b080 Wenchao Hao 2022-11-07  1689  		return NULL;
3aa534a2c8b080 Wenchao Hao 2022-11-07  1690  
3aa534a2c8b080 Wenchao Hao 2022-11-07 @1691  	return iscsi_session_target_state_names[state];
3aa534a2c8b080 Wenchao Hao 2022-11-07  1692  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

