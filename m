Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2076F08F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbjD0QAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244291AbjD0QAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:00:39 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01432422D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682611236; bh=rJy5VcfW0OjBjQxIinfMQ9k2tcMFglN0tA8NRTSeoRI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ls4qXGMju9KGD9v1H+L+4efhN7ClokfGdeOaGSomL4SrMHg5gRawRQQyRKwqYGc9DfU9L1xqxeWtcBymcNO0BUhC76Rz+14lPpOnmOYtWFDCwg3LcgsjskkMGJatm6zhCYD7JNT/PYdo/tG8L/gIEA+ApxQb785UO2AKaqX5oUoNm6Lqzd7BFjmMh62CikEcpJzTlXC9gfewGZTocJT8oqAv1AGOfLwKgxXUajf4l+Nxr6ApJH5kBzNv/9lf0r+wbokywf8gkLwQpPzkSqHTB7iYFBcQCAk6LribPRHDcy27eS3wJBYiiukLdNxQt5joMtJhLXYr4gpBOpNvnRthNA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682611236; bh=Z3rHliuU2Z+sZnDeIEKQPRlX2PcryOFszZN47Rmqpxg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QNdv3MzKBaEwkxXt9CXuh6ipsFv+u6gi/mBaf52FLJXnaBPw8S3gEf4QYjKrayJMJGMQZJzgXoSVpoLaztY24rWwCasMpT/RAEw2uyNUzKrbLE/1YSLM7nT4epoB/GMWgOI/xODHSZCwXy7zUDZ192pv9XFHbHHdYzI5OU76AIVz2fnYuJN0OdSXjDD3CHIn+sAaT5uwe5DzCUxGSJSNggP74QtN1WeFCLCLHbVnmnQzh7JnKQP3afscIT3XT9bGtgx861XoQs1TIqeWpsvZWWt1OchEqXgGUrPen/Uv3p2V4IOHfFhl0H4w2jqkTvDLlRagizNgbBvfWs5Kz4sYnA==
X-YMail-OSG: .xZn0G8VM1lwLH.in0CASJfluyt7hUqHnse6VnGorig5rzg5xGfdKM8w0GOJJsQ
 HYDQ.THhnWXHjwrCiuKezxwPLIlwKxQz88n5KBzj_iKk_x1m17XNkONWW2xcCi7_EHj.hl48vI4A
 PmGfyo2aKFuVrQ7CJTwgtXkiL3jbZu1rrWfirkmY86NA_FP3.lFXN7EojNUiEMP5jocQPq29ixnE
 Xk0lbLUSyB.3KuV_FzNO1BHAQFMBcDp8f6byEEmpuw_k0HX6RRn4gD3VdAxowjHriZ_HaHjJom12
 XY_iCfEFwwrpc92_9D.9Idk0wGDDhKP5WM9lBlJe4LCOZQQvcXII5froAtaSha2RHx8yVxJRni9t
 q7RlRhm5sZRQEqLTKrL_7DT._1EJNMKicfppzhqoi7yXeBD9tgqaHXXcfn61QLlHnkgok3eX0.PP
 hJXBBVdB4NaQVO_8bwU3xlbXh3fdAOf2IUm7yDGmv8NuLNcKn.z78aKOBfm1kT9GPIbg1awvJR_P
 X_6a0Wgo3djDrj4wkuHSONB1d_VUsthFv9v1Vo5OeeFFKqg2eTG4kpee8yy.kPhxeMv.bczuNerB
 BV.yHc2o23LS8xoe..hIgquWsbX3KjzrIK2hbwg57x6SREbTH69XSLDoQ5gzg08C6xT3x_q5hQ6r
 CkPlgmPavnzWLy7EEYI5Tkju19aMS_uc5yDbpl6iy4cfj_4AXOtXgl_u_Cx_uNVhzzDe2UlIqX2.
 LzwA6zUWHv0XkmbST0mAzSs7T3tQ29mnC45pcaitrTGH6anX_tGfpgUx6G.DxMbU5FmgifyZcyqC
 t.yQ9uHnludlxtUtCvTcKsy0yaufCGpMenpVoB_2TDtSW4r3nZxtFTBRgn3WaSoZUJyHh_ne.QE6
 DFKYl2rDY_nudBClTMBjbwMH8nwZtPC_hIR_5oixUrEklOJNtRwr8YcLj5Oal0iMDIuVKtEdjOGF
 E02X9N4KSSlgfVzUce6QS.e74zrslCW8CSkhYEzwzxeoLrHqzzT6ErpjTzWxYXsSovAuTPQt7SDj
 oEcwl3.R05w9lGHPTOwZ0JHyqSAgPWNxU9wHLnGAvkRS0TFrqhUmJqsmRJs.DnBzjXOXLSHcYLUm
 AmfJM98j2kqCiFjvlfVD8y6IAUSO59.hHY4bEiilhkk7E2P4W8.aHITdT6mvjH8iixCgJyN04PZI
 sXk4D9wZHE7FdTuCuRfpAZzCqLkObqTyIZkuV5.Ym9u9MEsvpKctLtqgJjF6UrDW_bo0clVsWHR7
 1GVLro2cAvNQ5XnMSSz7AJibDshWm4wEKdy5v4BZsUdh4zFPB3T_TcUM7nqKquaIzq4OhVSu5gaZ
 efYw_pdWB5O69aYvb7552J8eZYnjH7C5BF.zBWRYvhcFdssJIchahKQvqDCw.q0PW2enXlpb6Ima
 rH.Qc8DNd5jM.gmujRt1koJ3i.XjTFVVuOcHJgAh_y9zRHshIV8Oim837ZZ2EWD2oX8LsDqHj8E2
 63rVCrQAHuEZ1969Iisuz1rQEXnrLtK8KYkZuJ4kSvCZMIvDKvCdHMEKi6fVgEP6AwBWP.2YzSEZ
 OXvRhwRu06IWtYaA7sivL2sUL.X2mAEEAk.eRZCk3N8sVkHEQ07NfnlBxwKfwmuIh4IpASOVuHAc
 a6ZtbK93wImiOL2KRJJZxkq67wZ8rkzCvzX5o0UUTBp0M0KGvchTK5dFJ6IQvwepETfZwsKZ_N47
 REllb8Bg3aOj0yFIhhCZa65jSUtPcGf5Aq6use67sBYoNhF_kQdoJZhGSV.foZcEyk4EaVLZqtCv
 T8eQRQ5kMZzeuPpQ_EHCTh4q3w9q3TlyFvexyhNBvf0ctOlRoGbD2HNOoxm9RbqigmXSh0EEx1Di
 iz_YIKcwNbtu2k8E0wPXDGj.8YlMgcC3nGjKi1pSRWgc9KmaULGwAiwendYijC_T36cvcac6vci3
 ESn6.djUp99UYoV1sHd7.WxsQEgm5CQY8NaQ2BoDLFzRKQwTceP7NgICfena9Xncp7EpgodvWkEV
 kHNfWJYra_F6S22IVYfP4GhyVvKuEmtX9rQhZLGzJOlkIbpPGaA9U2EHE5fqV_H5VUIovYkPWXEf
 zSK.iP0MvXvFYiQJMGyg.VQlx7mCcw5OxDgqHc3XFemOwSB6j7JXKZReoHCJ2Uj.JjlsLxsBbePk
 84YGBNMv6DAMjJVUO0rh6c4spF07CFmHc2e5n0XhU7mh_49ps9CKzxvLDixqXafvg67rtyc22nBY
 eVnCz6DrzpSBENeysziqdPzbI1p2K5ulu2N_B.Ze89kwfNdJHYP.DAyb.i2BLggCApididsnYcGt
 BpODhTPAhLZuxeg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 433f5e30-1758-4639-97c7-1d9e89e40809
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Apr 2023 16:00:36 +0000
Received: by hermes--production-bf1-5f9df5c5c4-t7bzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 27ef797cdadf32b96c4d525dbc484e5c;
          Thu, 27 Apr 2023 16:00:32 +0000 (UTC)
Message-ID: <865cc0b8-38d4-687c-4bfa-06615cd5a23e@schaufler-ca.com>
Date:   Thu, 27 Apr 2023 09:00:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 11/11] LSM: selftests for Linux Security Module
 syscalls
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-12-casey@schaufler-ca.com>
 <6442eb94.170a0220.25865.0ef6@mx.google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6442eb94.170a0220.25865.0ef6@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/2023 1:01 PM, Kees Cook wrote:
> On Fri, Apr 21, 2023 at 10:42:59AM -0700, Casey Schaufler wrote:
>> Add selftests for the three system calls supporting the LSM
>> infrastructure.
> Yay tests!
>
> With nits below fixed:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  tools/testing/selftests/Makefile              |   1 +
>>  tools/testing/selftests/lsm/Makefile          |  12 +
>>  tools/testing/selftests/lsm/config            |   2 +
>>  .../selftests/lsm/lsm_get_self_attr_test.c    | 267 ++++++++++++++++++
>>  .../selftests/lsm/lsm_list_modules_test.c     | 149 ++++++++++
>>  .../selftests/lsm/lsm_set_self_attr_test.c    |  70 +++++
>>  6 files changed, 501 insertions(+)
>>  create mode 100644 tools/testing/selftests/lsm/Makefile
>>  create mode 100644 tools/testing/selftests/lsm/config
>>  create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>>  create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
>>  create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 13a6837a0c6b..b18d133a1141 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -38,6 +38,7 @@ TARGETS += landlock
>>  TARGETS += lib
>>  TARGETS += livepatch
>>  TARGETS += lkdtm
>> +TARGETS += lsm
>>  TARGETS += membarrier
>>  TARGETS += memfd
>>  TARGETS += memory-hotplug
>> diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
>> new file mode 100644
>> index 000000000000..f39a75212b78
>> --- /dev/null
>> +++ b/tools/testing/selftests/lsm/Makefile
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# First run: make -C ../../../.. headers_install
>> +
>> +CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
>> +
>> +TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
>> +		  lsm_set_self_attr_test
>> +
>> +include ../lib.mk
>> +
>> +$(TEST_GEN_PROGS):
>> diff --git a/tools/testing/selftests/lsm/config b/tools/testing/selftests/lsm/config
>> new file mode 100644
>> index 000000000000..afb887715f64
>> --- /dev/null
>> +++ b/tools/testing/selftests/lsm/config
>> @@ -0,0 +1,2 @@
>> +CONFIG_SYSFS=y
>> +CONFIG_SECURITY=y
>> diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>> new file mode 100644
>> index 000000000000..71c2b1a8a44e
>> --- /dev/null
>> +++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>> @@ -0,0 +1,267 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Linux Security Module infrastructure tests
>> + * Tests for the lsm_get_self_attr system call
>> + *
>> + * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
>> + * Copyright © 2022 Intel Corporation
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <linux/lsm.h>
>> +#include <fcntl.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <sys/types.h>
>> +#include "../kselftest_harness.h"
>> +
>> +#define PROCATTR	"/proc/self/attr/"
>> +
>> +static int read_proc_attr(const char *attr, char *value, __kernel_size_t size)
>> +{
>> +	int fd;
>> +	int len;
>> +	char *path;
>> +
>> +	len = strlen(PROCATTR) + strlen(attr) + 1;
>> +	path = calloc(len, 1);
>> +	if (path == NULL)
>> +		return -1;
>> +	sprintf(path, "%s%s", PROCATTR, attr);
>> +
>> +	fd = open(path, O_RDONLY);
>> +	free(path);
>> +
>> +	if (fd < 0)
>> +		return -1;
>> +	len = read(fd, value, size);
>> +	if (len <= 0)
>> +		return -1;
>> +fprintf(stderr, "len=%d\n", len);
> Accidentally leftover debugging?

Yup.


>> +	close(fd);
>> +
>> +	path = strchr(value, '\n');
>> +	if (path)
>> +		*path = '\0';
>> +
>> +	return 0;
>> +}
>> +
>> +static struct lsm_ctx *next_ctx(struct lsm_ctx *ctxp)
>> +{
>> +	void *vp;
>> +
>> +	vp = (void *)ctxp + sizeof(*ctxp) + ctxp->ctx_len;
>> +	return (struct lsm_ctx *)vp;
>> +}
>> +
>> +TEST(size_null_lsm_get_self_attr)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	char *ctx = calloc(page_size, 1);
>> +
>> +	ASSERT_NE(NULL, ctx);
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
>> +			      NULL, 0));
>> +	ASSERT_EQ(EINVAL, errno);
>> +
>> +	free(ctx);
>> +}
>> +
>> +TEST(ctx_null_lsm_get_self_attr)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	__kernel_size_t size = page_size;
>> +
>> +	ASSERT_NE(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, NULL,
>> +			      &size, 0));
>> +	ASSERT_NE(1, size);
>> +}
>> +
>> +TEST(size_too_small_lsm_get_self_attr)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	char *ctx = calloc(page_size, 1);
>> +	__kernel_size_t size = 1;
>> +
>> +	ASSERT_NE(NULL, ctx);
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
>> +			      &size, 0));
>> +	ASSERT_EQ(E2BIG, errno);
>> +	ASSERT_NE(1, size);
>> +
>> +	free(ctx);
>> +}
>> +
>> +TEST(flags_zero_lsm_get_self_attr)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	char *ctx = calloc(page_size, 1);
>> +	__kernel_size_t size = page_size;
>> +
>> +	ASSERT_NE(NULL, ctx);
> I would explicitly set errno to 0 before syscalls, just to sure.

Good idea for the cases where errno gets checked.


>> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
>> +			      &size, 1));
>> +	ASSERT_EQ(EINVAL, errno);
>> +	ASSERT_EQ(page_size, size);
>> +
>> +	free(ctx);
>> +}
>> +
>> +TEST(flags_overset_lsm_get_self_attr)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	char *ctx = calloc(page_size, 1);
>> +	__kernel_size_t size = page_size;
>> +
>> +	ASSERT_NE(NULL, ctx);
> e.g.:
> 	errno = 0;
>
> but repeated for all syscalls below...
>
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr,
>> +			      LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx, &size, 0));
>> +	ASSERT_EQ(EOPNOTSUPP, errno);
>> +
>> +	free(ctx);
>> +}
>> +
>> +TEST(basic_lsm_get_self_attr)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	__kernel_size_t size = page_size;
>> +	struct lsm_ctx *ctx = calloc(page_size, 1);
>> +	struct lsm_ctx *tctx = NULL;
>> +	__u64 *syscall_lsms = calloc(page_size, 1);
>> +	char *attr = calloc(page_size, 1);
>> +	int cnt_current = 0;
>> +	int cnt_exec = 0;
>> +	int cnt_fscreate = 0;
>> +	int cnt_keycreate = 0;
>> +	int cnt_prev = 0;
>> +	int cnt_sockcreate = 0;
>> +	int lsmcount;
>> +	int count;
>> +	int i;
>> +
>> +	ASSERT_NE(NULL, ctx);
>> +	ASSERT_NE(NULL, syscall_lsms);
>> +
>> +	lsmcount = syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0);
>> +	ASSERT_LE(1, lsmcount);
>> +
>> +	for (i = 0; i < lsmcount; i++) {
>> +		switch (syscall_lsms[i]) {
>> +		case LSM_ID_SELINUX:
>> +			cnt_current++;
>> +			cnt_exec++;
>> +			cnt_fscreate++;
>> +			cnt_keycreate++;
>> +			cnt_prev++;
>> +			cnt_sockcreate++;
>> +			break;
>> +		case LSM_ID_SMACK:
>> +			cnt_current++;
>> +			break;
>> +		case LSM_ID_APPARMOR:
>> +			cnt_current++;
>> +			cnt_exec++;
>> +			cnt_prev++;
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (cnt_current) {
>> +		size = page_size;
>> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
>> +				&size, 0);
>> +		ASSERT_EQ(cnt_current, count);
>> +		tctx = ctx;
>> +		ASSERT_EQ(0, read_proc_attr("current", attr, page_size));
>> +		ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
>> +		for (i = 1; i < count; i++) {
>> +			tctx = next_ctx(tctx);
>> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
>> +		}
>> +	}
>> +	if (cnt_exec) {
>> +		size = page_size;
>> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_EXEC, ctx,
>> +				&size, 0);
>> +		ASSERT_GE(cnt_exec, count);
>> +		if (count > 0) {
>> +			tctx = ctx;
>> +			if (read_proc_attr("exec", attr, page_size) == 0)
>> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
>> +		}
>> +		for (i = 1; i < count; i++) {
>> +			tctx = next_ctx(tctx);
>> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
>> +		}
>> +	}
>> +	if (cnt_fscreate) {
>> +		size = page_size;
>> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_FSCREATE, ctx,
>> +				&size, 0);
>> +		ASSERT_GE(cnt_fscreate, count);
>> +		if (count > 0) {
>> +			tctx = ctx;
>> +			if (read_proc_attr("fscreate", attr, page_size) == 0)
>> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
>> +		}
>> +		for (i = 1; i < count; i++) {
>> +			tctx = next_ctx(tctx);
>> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
>> +		}
>> +	}
>> +	if (cnt_keycreate) {
>> +		size = page_size;
>> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_KEYCREATE, ctx,
>> +				&size, 0);
>> +		ASSERT_GE(cnt_keycreate, count);
>> +		if (count > 0) {
>> +			tctx = ctx;
>> +			if (read_proc_attr("keycreate", attr, page_size) == 0)
>> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
>> +		}
>> +		for (i = 1; i < count; i++) {
>> +			tctx = next_ctx(tctx);
>> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
>> +		}
>> +	}
>> +	if (cnt_prev) {
>> +		size = page_size;
>> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_PREV, ctx,
>> +				&size, 0);
>> +		ASSERT_GE(cnt_prev, count);
>> +		if (count > 0) {
>> +			tctx = ctx;
>> +			ASSERT_EQ(0, read_proc_attr("prev", attr, page_size));
>> +			ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
>> +			for (i = 1; i < count; i++) {
>> +				tctx = next_ctx(tctx);
>> +				ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
>> +			}
>> +		}
>> +	}
>> +	if (cnt_sockcreate) {
>> +		size = page_size;
>> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_SOCKCREATE,
>> +				ctx, &size, 0);
>> +		ASSERT_GE(cnt_sockcreate, count);
>> +		if (count > 0) {
>> +			tctx = ctx;
>> +			if (read_proc_attr("sockcreate", attr, page_size) == 0)
>> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
>> +		}
>> +		for (i = 1; i < count; i++) {
>> +			tctx = next_ctx(tctx);
>> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
>> +		}
>> +	}
>> +
>> +	free(ctx);
>> +	free(attr);
>> +	free(syscall_lsms);
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
>> new file mode 100644
>> index 000000000000..3ec814002710
>> --- /dev/null
>> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
>> @@ -0,0 +1,149 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Linux Security Module infrastructure tests
>> + * Tests for the lsm_list_modules system call
>> + *
>> + * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
>> + * Copyright © 2022 Intel Corporation
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <linux/lsm.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <sys/types.h>
>> +#include "../kselftest_harness.h"
>> +
>> +static int read_sysfs_lsms(char *lsms, __kernel_size_t size)
>> +{
>> +	FILE *fp;
>> +
>> +	fp = fopen("/sys/kernel/security/lsm", "r");
>> +	if (fp == NULL)
>> +		return -1;
>> +	if (fread(lsms, 1, size, fp) <= 0)
>> +		return -1;
>> +	fclose(fp);
>> +	return 0;
>> +}
>> +
>> +TEST(size_null_lsm_list_modules)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	char *syscall_lsms = calloc(page_size, 1);
>> +
>> +	ASSERT_NE(NULL, syscall_lsms);
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, syscall_lsms, NULL, 0));
>> +	ASSERT_EQ(EFAULT, errno);
>> +
>> +	free(syscall_lsms);
>> +}
>> +
>> +TEST(ids_null_lsm_list_modules)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	__kernel_size_t size = page_size;
>> +
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, NULL, &size, 0));
>> +	ASSERT_EQ(EFAULT, errno);
>> +	ASSERT_NE(1, size);
>> +}
>> +
>> +TEST(size_too_small_lsm_list_modules)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	char *syscall_lsms = calloc(page_size, 1);
>> +	__kernel_size_t size = 1;
>> +
>> +	ASSERT_NE(NULL, syscall_lsms);
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0));
>> +	ASSERT_EQ(E2BIG, errno);
>> +	ASSERT_NE(1, size);
>> +
>> +	free(syscall_lsms);
>> +}
>> +
>> +TEST(flags_set_lsm_list_modules)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	char *syscall_lsms = calloc(page_size, 1);
>> +	__kernel_size_t size = page_size;
>> +
>> +	ASSERT_NE(NULL, syscall_lsms);
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, syscall_lsms, &size, 7));
>> +	ASSERT_EQ(EINVAL, errno);
>> +	ASSERT_EQ(page_size, size);
>> +
>> +	free(syscall_lsms);
>> +}
>> +
>> +TEST(correct_lsm_list_modules)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	__kernel_size_t size = page_size;
>> +	__u64 *syscall_lsms = calloc(page_size, 1);
>> +	char *sysfs_lsms = calloc(page_size, 1);
>> +	char *name;
>> +	char *cp;
>> +	int count;
>> +	int i;
>> +
>> +	ASSERT_NE(NULL, sysfs_lsms);
>> +	ASSERT_NE(NULL, syscall_lsms);
>> +	ASSERT_EQ(0, read_sysfs_lsms(sysfs_lsms, page_size));
>> +
>> +	count = syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0);
>> +	ASSERT_LE(1, count);
>> +	cp = sysfs_lsms;
>> +	for (i = 0; i < count; i++) {
>> +		switch (syscall_lsms[i]) {
>> +		case LSM_ID_CAPABILITY:
>> +			name = "capability";
>> +			break;
>> +		case LSM_ID_SELINUX:
>> +			name = "selinux";
>> +			break;
>> +		case LSM_ID_SMACK:
>> +			name = "smack";
>> +			break;
>> +		case LSM_ID_TOMOYO:
>> +			name = "tomoyo";
>> +			break;
>> +		case LSM_ID_IMA:
>> +			name = "ima";
>> +			break;
>> +		case LSM_ID_APPARMOR:
>> +			name = "apparmor";
>> +			break;
>> +		case LSM_ID_YAMA:
>> +			name = "yama";
>> +			break;
>> +		case LSM_ID_LOADPIN:
>> +			name = "loadpin";
>> +			break;
>> +		case LSM_ID_SAFESETID:
>> +			name = "safesetid";
>> +			break;
>> +		case LSM_ID_LOCKDOWN:
>> +			name = "lockdown";
>> +			break;
>> +		case LSM_ID_BPF:
>> +			name = "bpf";
>> +			break;
>> +		case LSM_ID_LANDLOCK:
>> +			name = "landlock";
>> +			break;
>> +		default:
>> +			name = "INVALID";
>> +			break;
>> +		}
>> +		ASSERT_EQ(0, strncmp(cp, name, strlen(name)));
>> +		cp += strlen(name) + 1;
>> +	}
>> +
>> +	free(sysfs_lsms);
>> +	free(syscall_lsms);
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>> new file mode 100644
>> index 000000000000..ca538a703168
>> --- /dev/null
>> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>> @@ -0,0 +1,70 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Linux Security Module infrastructure tests
>> + * Tests for the lsm_set_self_attr system call
>> + *
>> + * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
>> + * Copyright © 2022 Intel Corporation
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <linux/lsm.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <sys/types.h>
>> +#include "../kselftest_harness.h"
>> +
>> +TEST(ctx_null_lsm_set_self_attr)
>> +{
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, LSM_ATTR_CURRENT, NULL,
>> +			      sizeof(struct lsm_ctx), 0));
>> +}
>> +
>> +TEST(size_too_small_lsm_set_self_attr)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	struct lsm_ctx *ctx = calloc(page_size, 1);
>> +	__kernel_size_t size = page_size;
>> +
>> +	ASSERT_NE(NULL, ctx);
>> +	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
>> +			     &size, 0));
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, LSM_ATTR_CURRENT, ctx, 1,
>> +			      0));
>> +
>> +	free(ctx);
>> +}
>> +
>> +TEST(flags_zero_lsm_set_self_attr)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	char *ctx = calloc(page_size, 1);
>> +	__kernel_size_t size = page_size;
>> +
>> +	ASSERT_NE(NULL, ctx);
>> +	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
>> +			     &size, 0));
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, LSM_ATTR_CURRENT, ctx,
>> +			      size, 1));
>> +
>> +	free(ctx);
>> +}
>> +
>> +TEST(flags_overset_lsm_set_self_attr)
>> +{
>> +	const long page_size = sysconf(_SC_PAGESIZE);
>> +	char *ctx = calloc(page_size, 1);
>> +	__kernel_size_t size = page_size;
>> +	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
>> +
>> +	ASSERT_NE(NULL, ctx);
>> +	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, tctx,
>> +			     &size, 0));
>> +	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr,
>> +			      LSM_ATTR_CURRENT | LSM_ATTR_PREV, tctx, size, 0));
>> +
>> +	free(ctx);
>> +}
>> +
>> +TEST_HARNESS_MAIN
>> -- 
>> 2.39.2
>>
