Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19966B0E09
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjCHQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjCHQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:00:17 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B42591C8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:59:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3BF31604F5;
        Wed,  8 Mar 2023 16:59:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678291185; bh=XDOyW8oTPC52E4prCyOAflqfBsw1DA0NlOduNcFlPdA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U7Vzf2+BHpbtKhPU0SghwFuSbmjeTONyxFfjPiY9WszzotQzgKwm2CXasz/pwFtlZ
         hN3VAIBhar+y9LAzjK6aBVf+MTDWcTr2q5gHP7nRyxg0vkCOpIysHnD8NMTrf9rlDF
         xAM3WCcdwzaKE9B5BVsGP2AJ1ILnqXw4rd3nnmSMiRDp5M5UG6WAdskSSOp5CbPTyj
         b+KtsRidrTqPoZWF3H7AwlRbwRbCX6UOZpTdtwolT0XyTssCJRJtDrIj3qCPE5628P
         cPJyrwK5edLkYm0co9lxYLccdQr46X4jUGorgRdCSYRPYi+sLrVwH5Ky0tyDbXQhi7
         abDr5KU2cbzLw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id meCezhYF9unx; Wed,  8 Mar 2023 16:59:42 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 20CDC604F3;
        Wed,  8 Mar 2023 16:59:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678291182; bh=XDOyW8oTPC52E4prCyOAflqfBsw1DA0NlOduNcFlPdA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UfPxQQDDqifr0GiHN0nKaoMBVZOAKTPsI9UOcxNSZ6dhmYAXiiZZyTAALK6oOIgCp
         NWixIN2vxvI+Zxk9VJ1zWgsWDi52WWMRXGRMv4RIfsjwdlD4pg8XsLNPB80UpJg5Hb
         ZrlFVfBk3Q3zMIRdqIUm+65Gauw2kM9liYNjgOTstqqVwfy+ilb/ybb8+yKg9gy9iG
         2YzUOwu2MWMaFi4iV3hCVlflEFPDLSMvI15ulb6ASpLMPAn0LW2aLlgL7pzc0zRhQT
         EghqlsQvxTiClnHAB0zOG5H+jHY/p0/kt4NMiPX29+PfaQps+UlUB/Z8DHpy/wVjnC
         /Ny6VNpdocdHA==
Message-ID: <219c5d09-0099-83e9-b21b-299fa513decd@alu.unizg.hr>
Date:   Wed, 8 Mar 2023 16:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 8/8] selftests/proc: Assert clock_gettime(CLOCK_BOOTTIME)
 VS /proc/uptime monotonicity
Content-Language: en-US, hr
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
References: <20230222144649.624380-1-frederic@kernel.org>
 <20230222144649.624380-9-frederic@kernel.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230222144649.624380-9-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On 2/22/23 15:46, Frederic Weisbecker wrote:
> The first field of /proc/uptime relies on the CLOCK_BOOTTIME clock which
> can also be fetched from clock_gettime() API.
> 
> Improve the test coverage while verifying the monotonicity of
> CLOCK_BOOTTIME accross both interfaces.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yu Liao <liaoyu15@huawei.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Wei Li <liwei391@huawei.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   .../testing/selftests/proc/proc-uptime-001.c  | 21 ++++++++++++++----
>   .../testing/selftests/proc/proc-uptime-002.c  | 22 +++++++++++++++----
>   tools/testing/selftests/proc/proc-uptime.h    | 12 ++++++++++
>   3 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/proc-uptime-001.c b/tools/testing/selftests/proc/proc-uptime-001.c
> index 35bddd9dd60b..f335eec5067e 100644
> --- a/tools/testing/selftests/proc/proc-uptime-001.c
> +++ b/tools/testing/selftests/proc/proc-uptime-001.c
> @@ -13,9 +13,9 @@
>    * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
>    * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>    */
> -// Test that boottime value in /proc/uptime increments monotonically.
> -// We don't test idle time monotonicity due to broken iowait task
> -// counting, cf: comment above get_cpu_idle_time_us()
> +// Test that boottime value in /proc/uptime and CLOCK_BOOTTIME increment
> +// monotonically. We don't test idle time monotonicity due to broken iowait
> +// task counting, cf: comment above get_cpu_idle_time_us()
>   #undef NDEBUG
>   #include <assert.h>
>   #include <stdint.h>
> @@ -27,7 +27,7 @@
>   
>   int main(void)
>   {
> -	uint64_t start, u0, u1;
> +	uint64_t start, u0, u1, c0, c1;
>   	int fd;
>   
>   	fd = open("/proc/uptime", O_RDONLY);
> @@ -35,10 +35,23 @@ int main(void)
>   
>   	u0 = proc_uptime(fd);
>   	start = u0;
> +	c0 = clock_boottime();
> +
>   	do {
>   		u1 = proc_uptime(fd);
> +		c1 = clock_boottime();
> +
> +		/* Is /proc/uptime monotonic ? */
>   		assert(u1 >= u0);
> +
> +		/* Is CLOCK_BOOTTIME monotonic ? */
> +		assert(c1 >= c0);
> +
> +		/* Is CLOCK_BOOTTIME VS /proc/uptime monotonic ? */
> +		assert(c0 >= u0);
> +
>   		u0 = u1;
> +		c0 = c1;
>   	} while (u1 - start < 100);
>   
>   	return 0;
> diff --git a/tools/testing/selftests/proc/proc-uptime-002.c b/tools/testing/selftests/proc/proc-uptime-002.c
> index 7ad79d5eaa84..ae453daa96c1 100644
> --- a/tools/testing/selftests/proc/proc-uptime-002.c
> +++ b/tools/testing/selftests/proc/proc-uptime-002.c
> @@ -13,9 +13,10 @@
>    * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
>    * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>    */
> -// Test that boottime value in /proc/uptime increments monotonically
> -// while shifting across CPUs. We don't test idle time monotonicity
> -// due to broken iowait task counting, cf: comment above get_cpu_idle_time_us()
> +// Test that boottime value in /proc/uptime and CLOCK_BOOTTIME increment
> +// monotonically while shifting across CPUs. We don't test idle time
> +// monotonicity due to broken iowait task counting, cf: comment above
> +// get_cpu_idle_time_us()
>   #undef NDEBUG
>   #include <assert.h>
>   #include <errno.h>
> @@ -43,10 +44,10 @@ static inline int sys_sched_setaffinity(pid_t pid, unsigned int len, unsigned lo
>   
>   int main(void)
>   {
> +	uint64_t u0, u1, c0, c1;
>   	unsigned int len;
>   	unsigned long *m;
>   	unsigned int cpu;
> -	uint64_t u0, u1;
>   	int fd;
>   
>   	/* find out "nr_cpu_ids" */
> @@ -62,6 +63,8 @@ int main(void)
>   	assert(fd >= 0);
>   
>   	u0 = proc_uptime(fd);
> +	c0 = clock_boottime();
> +
>   	for (cpu = 0; cpu < len * 8; cpu++) {
>   		memset(m, 0, len);
>   		m[cpu / (8 * sizeof(unsigned long))] |= 1UL << (cpu % (8 * sizeof(unsigned long)));
> @@ -70,8 +73,19 @@ int main(void)
>   		sys_sched_setaffinity(0, len, m);
>   
>   		u1 = proc_uptime(fd);
> +		c1 = clock_boottime();
> +
> +		/* Is /proc/uptime monotonic ? */
>   		assert(u1 >= u0);
> +
> +		/* Is CLOCK_BOOTTIME monotonic ? */
> +		assert(c1 >= c0);
> +
> +		/* Is CLOCK_BOOTTIME VS /proc/uptime monotonic ? */
> +		assert(c0 >= u0);
> +
>   		u0 = u1;
> +		c0 = c1;
>   	}
>   
>   	return 0;
> diff --git a/tools/testing/selftests/proc/proc-uptime.h b/tools/testing/selftests/proc/proc-uptime.h
> index ca55abeb0ccc..730cce4a3d73 100644
> --- a/tools/testing/selftests/proc/proc-uptime.h
> +++ b/tools/testing/selftests/proc/proc-uptime.h
> @@ -19,9 +19,21 @@
>   #include <string.h>
>   #include <stdlib.h>
>   #include <unistd.h>
> +#include <time.h>
>   
>   #include "proc.h"
>   
> +static uint64_t clock_boottime(void)
> +{
> +	struct timespec ts;
> +	int err;
> +
> +	err = clock_gettime(CLOCK_BOOTTIME, &ts);
> +	assert(err >= 0);
> +
> +	return (ts.tv_sec * 100) + (ts.tv_nsec / 10000000);
> +}
> +
>   static uint64_t proc_uptime(int fd)
>   {
>   	uint64_t val1, val2;

 From what I see, you round the CLOCK_BOOTIME time to 1/100ths of a second.

A simple program that queries clock_getres() on system clocks gives this
result:

clock_res [CLOCK_REALTIME] = 0.000000001s
clock_res [CLOCK_REALTIME_COARSE] = 0.004000000s
clock_res [CLOCK_MONOTONIC] = 0.000000001s
clock_res [CLOCK_MONOTONIC_COARSE] = 0.004000000s
clock_res [CLOCK_MONOTONIC_RAW] = 0.000000001s
clock_res [CLOCK_BOOTTIME] = 0.000000001s
clock_res [CLOCK_PROCESS_CPUTIME_ID] = 0.000000001s
clock_res [CLOCK_THREAD_CPUTIME_ID] = 0.000000001s

A number of programs may depend i.e. on CLOCK_REALTIME or CLOCK_BOOTIME to give
different result each nanosecond.

I came across this when generating nonces for HMACs according to recommendations
from RFC 4086 "Randomness Requirements for Security".

If the value of CLOCK_BOOTTIME or CLOCK_REALTIME is incremented not in what
clock_getres() gives, but at best in 1/100th of second instead, that would seriously
weaken our security (for as you know, in many cryptographic uses nonces need not
be random, but MUST NOT ever repeat nor go backwards).

Could we modify the test for this assumption, or is the assumption wrong?

Here the test for CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID
increasing monotonically with guaranteed increased value of nanoseconds
would also seem good.

Maybe this is already covered in another test case, but it seems that all
clocks should be guaranteed to be monotonically increasing, and increased
at least by one nanosecond with each syscall, or many algorithms would break.

In other words, CLOCK_BOOTTIME should be tested to increase monotonically in
the resolution given by clock_getres (CLOCK_BOOTTIME, &tv_res), not in 1/100ths
of second (IMHO).

Am I wrong in my assumption?

Thank you,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
