Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED30170C24C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjEVPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjEVPXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:23:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2481BD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:23:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f607e60902so4854705e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684768982; x=1687360982;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlPB+i0cWBReL9bMCFIoxhk9rmbhDvxNKsZ3lFgJML0=;
        b=lqSpgql+BOR13T/DPFK4QhJ+PvCbAF1ur11Uri5H22adpiTIBqgWxbQ2BzrWiuL56s
         ryq/B2pRIs/wLaPUdyKIa/75s0DIvXW3T4jCeymkh7Qi2cXf97eu0CYGQpf0me+Wd97k
         B9SGFqBK5GJl11w2GXCytBRWKCufsfgS08mF3tzPyuMBP2mMR49n5POPiF567Zb37mBV
         vq69mQaL9ePkuIlxchQS03JDZC0ZWtvT/bZbe5I6J7uQkoGPqk8idbr+pG6D+1pSM8Vx
         cfDyFavvzCMfd5IR+ZeAWb3VPaJbieyeLQnn3Odk2KvChKjzD7QI6HJsgg3OSVgIbXAy
         SM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684768982; x=1687360982;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlPB+i0cWBReL9bMCFIoxhk9rmbhDvxNKsZ3lFgJML0=;
        b=epXYBwnWjhwo9WL1vT6Mo0eeoKPs5d1g9l2DuJpTI+KNgeq3PK13I2IZ5m9hvJ95fK
         sQ0BZqQnlhW8uEwqU3VD071cVP7uaQOu4/xwaZnVfEWpb62TVlJHROjW4d8epA2hA8Bj
         a11tm5EAvpdo7bPIngV8D21zpjIqnBjChKOmNg7YEAx121WYbJKMO34qIL6scQAALh9I
         /2pkrhgX9utUUyJIJh0j3H/4fbCPYjwJxJFSf4MKDarFA09oeNrCdeZii5/NekjT5ynS
         XztoYKRT+mbP/Y1dJXYKM/J9oGPYdbGC0cJ4I34ZtzSjqnw3RSSNWoG72AB7Rn8WaWXV
         9I3w==
X-Gm-Message-State: AC+VfDx5eUkFaFoKXUc550gf8n/NDOG0LUozZXoPv4B28C3OtMoYBjld
        zqZ7woZzcjm+yh/oNVPV7h/mDw==
X-Google-Smtp-Source: ACHHUZ4tYdrAVOYSrnuXTirvCvb4gKea7CA/iXGwZIZIvSAPARI9ESvbCR5TDys6jloKFC2c5S4V1g==
X-Received: by 2002:a05:600c:21ca:b0:3f1:819d:d050 with SMTP id x10-20020a05600c21ca00b003f1819dd050mr7955563wmj.37.1684768981806;
        Mon, 22 May 2023 08:23:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bcb99000000b003f195d540d9sm11966879wmi.14.2023.05.22.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:22:59 -0700 (PDT)
Date:   Mon, 22 May 2023 18:22:56 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: fs/nfs/nfs42xdr.c:1131 decode_read_plus() warn: missing error code?
 'status'
Message-ID: <20fe9f09-fe92-4a9f-a14d-853175e441bc@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44c026a73be8038f03dbdeef028b642880cf1511
commit: d3b00a802c845a6021148ce2e669b5a0b5729959 NFS: Replace the READ_PLUS decoding code
config: microblaze-randconfig-m041-20230522 (https://download.01.org/0day-ci/archive/20230522/202305222209.6l5VM2lL-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305222209.6l5VM2lL-lkp@intel.com/

New smatch warnings:
fs/nfs/nfs42xdr.c:1131 decode_read_plus() warn: missing error code? 'status'

Old smatch warnings:
fs/nfs/nfs4xdr.c:1194 encode_attrs() error: we previously assumed 'umask' could be null (see line 1103)

vim +/status +1131 fs/nfs/nfs42xdr.c

c567552612ece7 Anna Schumaker  2014-05-28  1108  static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
c567552612ece7 Anna Schumaker  2014-05-28  1109  {
82f98c8b116bd7 Trond Myklebust 2020-12-08  1110  	struct nfs_pgio_header *hdr =
82f98c8b116bd7 Trond Myklebust 2020-12-08  1111  		container_of(res, struct nfs_pgio_header, res);
82f98c8b116bd7 Trond Myklebust 2020-12-08  1112  	struct nfs_pgio_args *args = &hdr->args;
d3b00a802c845a Anna Schumaker  2022-07-21  1113  	uint32_t segments;
d3b00a802c845a Anna Schumaker  2022-07-21  1114  	struct read_plus_segment *segs;
bff049a3b5001e Anna Schumaker  2020-04-01  1115  	int status, i;
d3b00a802c845a Anna Schumaker  2022-07-21  1116  	char scratch_buf[16];
c567552612ece7 Anna Schumaker  2014-05-28  1117  	__be32 *p;
c567552612ece7 Anna Schumaker  2014-05-28  1118  
c567552612ece7 Anna Schumaker  2014-05-28  1119  	status = decode_op_hdr(xdr, OP_READ_PLUS);
c567552612ece7 Anna Schumaker  2014-05-28  1120  	if (status)
c567552612ece7 Anna Schumaker  2014-05-28  1121  		return status;
c567552612ece7 Anna Schumaker  2014-05-28  1122  
c567552612ece7 Anna Schumaker  2014-05-28  1123  	p = xdr_inline_decode(xdr, 4 + 4);
c567552612ece7 Anna Schumaker  2014-05-28  1124  	if (unlikely(!p))
c567552612ece7 Anna Schumaker  2014-05-28  1125  		return -EIO;
c567552612ece7 Anna Schumaker  2014-05-28  1126  
1ee6310119a5b4 Trond Myklebust 2020-12-08  1127  	res->count = 0;
d3b00a802c845a Anna Schumaker  2022-07-21  1128  	res->eof = be32_to_cpup(p++);
c567552612ece7 Anna Schumaker  2014-05-28  1129  	segments = be32_to_cpup(p++);
c567552612ece7 Anna Schumaker  2014-05-28  1130  	if (segments == 0)
d3b00a802c845a Anna Schumaker  2022-07-21 @1131  		return status;

This looks like intentional?  It's probably better to to do a literal
"return 0;"  Makes the static checkers happy.

c567552612ece7 Anna Schumaker  2014-05-28  1132  
d3b00a802c845a Anna Schumaker  2022-07-21  1133  	segs = kmalloc_array(segments, sizeof(*segs), GFP_KERNEL);
d3b00a802c845a Anna Schumaker  2022-07-21  1134  	if (!segs)
d3b00a802c845a Anna Schumaker  2022-07-21  1135  		return -ENOMEM;
c567552612ece7 Anna Schumaker  2014-05-28  1136  
d3b00a802c845a Anna Schumaker  2022-07-21  1137  	xdr_set_scratch_buffer(xdr, &scratch_buf, 32);
d3b00a802c845a Anna Schumaker  2022-07-21  1138  	status = -EIO;

This assignment is not used.

d3b00a802c845a Anna Schumaker  2022-07-21  1139  	for (i = 0; i < segments; i++) {
d3b00a802c845a Anna Schumaker  2022-07-21  1140  		status = decode_read_plus_segment(xdr, &segs[i]);
bff049a3b5001e Anna Schumaker  2020-04-01  1141  		if (status < 0)
d3b00a802c845a Anna Schumaker  2022-07-21  1142  			goto out;
bff049a3b5001e Anna Schumaker  2020-04-01  1143  	}
c567552612ece7 Anna Schumaker  2014-05-28  1144  
d3b00a802c845a Anna Schumaker  2022-07-21  1145  	xdr_set_pagelen(xdr, xdr_align_size(args->count));
d3b00a802c845a Anna Schumaker  2022-07-21  1146  	for (i = segments; i > 0; i--)
d3b00a802c845a Anna Schumaker  2022-07-21 @1147  		res->count += process_read_plus_segment(xdr, args, res, &segs[i-1]);
d3b00a802c845a Anna Schumaker  2022-07-21  1148  	status = 0;
d3b00a802c845a Anna Schumaker  2022-07-21  1149  
c567552612ece7 Anna Schumaker  2014-05-28  1150  out:
d3b00a802c845a Anna Schumaker  2022-07-21  1151  	kfree(segs);
d3b00a802c845a Anna Schumaker  2022-07-21  1152  	return status;
c567552612ece7 Anna Schumaker  2014-05-28  1153  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

